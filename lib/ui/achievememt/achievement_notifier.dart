import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod_providers.dart';
import 'package:myplantapp_ver1/domain/model/achievement_list.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/repository/i_inventory_repository.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_state.dart';
import 'package:myplantapp_ver1/ui/achievememt/widget/ach_with_flags.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_state.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'achievement_notifier.g.dart';

@riverpod
class AchievementNotifier extends _$AchievementNotifier {
  final log = AppLogger.tag("AchievementVM🏆");
  final uuid = Uuid();
  bool _listenRegistered = false;

  late final IInventoryRepository _inventoryRepo;
  late final UserState _userState;
  late final UserNotifier _userNf;
  late final MasterDataNotifier _masterData;

  @override
  Future<AchievementState> build() async {
    print("🔥 AchievementNotifier build()");
    // ✅ UserModel の rewardFlags のみ監視

    _inventoryRepo = await ref.read(inventoryRepositoryProvider.future);
    _userState = await ref.read(userNotifierProvider.future);

    _userNf = ref.read(userNotifierProvider.notifier);
    _masterData = ref.read(masterDataNotifierProvider.notifier);

    _setupUserListenOnce();
    final result = await _load();
    return result;
  }

  Future<AchievementState> _load() async {
    try {
      final list = await achWithFlagsCreate();
      // 初期 state
      var s = AchievementState(
        user: _userState.user,
        list: list,
        showUnlocked: true,
        showLocked: true,
        showReceived: true,
        loading: false,
      );

      final filtered = filterList(s);

      return s.copyWith(filteredList: filtered);
    } catch (e ,st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  void _setupUserListenOnce() {
    if (_listenRegistered) return;
    _listenRegistered = true;

    log.d("🔥 _setupUserListenOnce fire");
    // 🎯 actionFlags の変更 → 実績チェック
    ref.listen<List<String>>(
      userNotifierProvider.select(
            (userAsync) => userAsync.value?.user.actionFlags ?? const [],
      ),
          (prev, next) {
        if (prev != next) checkAchievements();
      },
    );

    // 🎯 rewardFlags の変更 → list 再作成
    ref.listen<List<String>>(
      userNotifierProvider.select(
            (userAsync) => userAsync.value?.user.rewardFlags ?? const [],
      ),
          (prev, next) async {
        if (prev != next) {
          final list = await achWithFlagsCreate();
          state = AsyncData(state.value!.copyWith(list: list));
          await rebuildFilteredList();

          log.d('list Only Reload 発火!! rewardFlags=${next}');
        }
      },
    );
  }

  /// ✅ フィルター更新
  void toggleShowUnlocked(bool value) {
    state = AsyncData(
      state.value!.copyWith(showUnlocked: value),
    );
    rebuildFilteredList();
  }

  void toggleShowLocked(bool value) {
    state = AsyncData(
      state.value!.copyWith(showLocked: value),
    );
    rebuildFilteredList();
  }

  void toggleShowshowReceived(bool value) {
    state = AsyncData(
      state.value!.copyWith(showReceived: value),
    );
    rebuildFilteredList();
  }

  Future<List<AchWithFlags>> achWithFlagsCreate() async{
    log.d('achWithFlagsCreate() 起動!');
    final userState = await ref.read(userNotifierProvider).requireValue;
    final achList = achievementList;
    final List<AchWithFlags> result = [];
    for (final ach in achList) {
      final unlocked = userState.user.rewardFlags.contains(ach.id);
      final rewarded = userState.user.rewardFlags.contains('${ach.id}_REWARDED');
      result.add(
        AchWithFlags(
          ach: ach,
          unlocked: unlocked,
          rewarded: rewarded,
        )
      );
    }
    return result;
  }

  List<AchWithFlags> filterList(AchievementState s) {
    return s.list.where((item) {
      if (!s.showUnlocked && item.unlocked) return false;
      if (!s.showLocked && !item.unlocked) return false;
      if (!s.showReceived && item.rewarded) return false;
      return true;
    }).toList();
  }

  Future<void> rebuildFilteredList() async {
    final s = state.value!;
    final filtered = s.list.where((item) {
      if (!s.showUnlocked  && item.unlocked) return false;
      if (!s.showLocked    && !item.unlocked) return false;
      if (!s.showReceived  && item.rewarded) return false;
      return true;
    }).toList();

    state = AsyncData(
      s.copyWith(filteredList: filtered),
    );
  }

  /// ✅ 実績データフィルタ
  List<Achievement> get filteredAchievements {
    final s = state.value;
    if (s == null) return [];

    final list = ref.read(achievementListProvider);
    final flags = s.user.rewardFlags;

    return list.where((a) {
      final unlocked = flags.contains(a.id);
      final rewarded = flags.contains('${a.id}_REWARDED');

      if (unlocked && !rewarded && s.showReceived) return true;
      if (unlocked && s.showUnlocked) return true;
      if (!unlocked && s.showLocked) return true;
      return false;
    }).toList();
  }

  /// 🏆 実績条件チェック
  Future<void> checkAchievements() async {
    log.d('🔥 checkAchievements() 起動!');


    final user = _userState.user;

    final collectedRepo = await ref.read(collectedRepositoryProvider.future);
    final collectedList = await collectedRepo.getAll();

    // 現在の達成フラグを取得
    final currentFlags = Set<String>.from(user.rewardFlags);
    final newlyFlags = <String>[];
    final newlyUnlocked = <Achievement>[];

    // ctx を作成（conditionで使用）
    final ctx = AchievementContext(user: user, collectedList: collectedList);

    // ✅ 未達成の実績のみフィルタしてチェック
    final pendingAchievements = achievementList
        .where((a) => !currentFlags.contains(a.id))
        .toList();

    // achievementList の全件を走査
    for (final achievement in pendingAchievements) {
      final reached = achievement.condition(ctx);

      if (reached) {
        newlyFlags.add(achievement.id);
        newlyUnlocked.add(achievement);

        log.i("🏆 実績解除: ${achievement.id} - ${achievement.titleKey}");
      }
    }
    // ✅ ユーザーを更新（新しいフラグを保存）
    if (newlyUnlocked.isNotEmpty) {
      await _userNf.addRewardFlags(flags: newlyFlags);
    } else {
      log.d('✅ 実績解除はありませんでした');
      return;
    }
    state = AsyncData(
      state.value!.copyWith(newlyUnlocked: newlyUnlocked),
    );
  }

  void flagClear() {
    state = AsyncData(
      state.value!.copyWith(newlyUnlocked: []),
    );
  }

  Future<bool> rewardReceive(Achievement ach) async {
    log.d('rewardReceive　起動!');
    final inventoryList = await _inventoryRepo.getAll();

    for (final rewardItem in ach.reward.items) {
      final masterItem = _masterData.findItemById(rewardItem.itemId);
      if (masterItem == null) continue;

      final existing = inventoryList.firstWhereOrNull(
        (p) => p.itemId == rewardItem.itemId
      );
      if(existing != null) {
        final updated = existing.copyWith(
          quantity: existing.quantity + rewardItem.quantity,
        );
        await _inventoryRepo.save(updated);
      } else {
        final newItem = Inventory(
            id: uuid.v4(),
            itemId: masterItem.id,
            itemType: masterItem.itemType,
            variant: masterItem.variant,
            attribute: masterItem.attribute,
            quantity: rewardItem.quantity
        );
        _inventoryRepo.save(newItem);
      }
    }
    await _userNf.addRewardFlags(coins: ach.reward.coins, flags: ['${ach.id}_REWARDED']);

    log.d('rewardReceive　完了!');
    return true;
  }
}