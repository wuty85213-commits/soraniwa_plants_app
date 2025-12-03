import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod.dart';
import 'package:myplantapp_ver1/domain/model/pot.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_repository.dart';
import 'package:myplantapp_ver1/ui/common/user_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  final log = AppLogger.tag("UserNotifier🏆");
  final uuid = Uuid();
  late IUserRepository _repo;

  @override
  Future<UserState> build() async {
    print("🔥 UserNotifier build()");

    _repo = await ref.read(userRepositoryProvider.future);

    final user = _repo.getUser();
    final pots = await _repo.potGetAll();

    return UserState(
      user: user,
      pots: pots,
    );
  }

  /// 🔄 手動リロード
  Future<void> reload() async {
    state = const AsyncLoading();

    try {
      _repo = await ref.read(userRepositoryProvider.future);
      final user = _repo.getUser();
      final pots = await _repo.potGetAll();

      state = AsyncData(
          UserState(
            user: user,
            pots: pots,
          )
      );
    } catch (e, st) {
      state = AsyncError(e, st);
      log.e("❌ reload failed: $e");
    }
  }

  Future<void> save(User user) async {
    log.d('save 起動!');
    await _repo.save(user);

    final current = state.value;
    if (current == null) {
      log.e("❌ state.value が null のため更新できません");
      return;
    }
    state = AsyncData(current.copyWith(user: user),);
    log.d('userをsaveしました! :${user.rewardFlags}');
  }

  Future<void> potSave(int slotIndex, int itemId) async {
    final value = state.requireValue;
    final existing = value.pots.firstWhereOrNull((e) => e.slotIndex == slotIndex);

    Pot newPot;
    if(existing != null) {
      newPot = existing.copyWith(itemId: itemId);
    } else {
      log.d('potが存在しません');
      newPot = Pot(id: uuid.v4(), slotIndex: slotIndex, itemId: itemId);
    }
    await _repo.potSave(newPot);

    final updatedList = [...value.pots.where((p) => p.slotIndex != slotIndex), newPot,];
    // State を手動で更新

    state = AsyncData(value.copyWith(pots: updatedList));
    log.d('Pots 更新: slot=$slotIndex → itemId=$itemId');
  }

  Future<void> addCoin(int coins) async{
    final value = state.requireValue;
    final user = value.user;
    final updated = user.copyWith(coins: user.coins + coins);
    await save(updated);
    log.d('add coin + ${updated.coins}');
  }

  Future<void> reduceCoin(int coins) async{
    final value = state.requireValue;
    final user = value.user;
    int newCoins = (user.coins - coins).clamp(0, double.infinity).toInt();
    final updated = user.copyWith(coins: newCoins);
    await save(updated);
  }

  //スロット拡張
  Future<bool> plantUnlock() async{
    final value = state.requireValue;
    final user = value.user;
    final price = await slotPrice();
    log.d('plantUnlock 起動!${price}');

    if(user.unlockedSlots > 5) {
      log.e('これ以上、鉢スロットを増やすことはできません : unlockslot${user.unlockedSlots}');
      return false;
    }
    if(user.coins < price) {
      log.e('コインが不足しています : userCoin(${user.coins}) < slotPrice($price)');
      return false;
    }
    final updated = user.copyWith(
        unlockedSlots: user.unlockedSlots + 1,
        coins: user.coins - price
    );
    save(updated);
    return true;
  }

  Future<void> addRewardFlags({int coins = 0, List<String> flags = const [],}) async{
    final value = state.requireValue;
    final user = value.user;
    final newCoins = user.coins + coins;
    final updated = user.copyWith(
        coins: newCoins,
        rewardFlags: [...user.rewardFlags,...flags,]
    );
    await save(updated);
  }

  Future<int> slotPrice() async{
    final value = state.requireValue;
    final user = value.user;
    final unlocked = user.unlockedSlots;
    switch(unlocked) {
      case 1: return 1000;
      case 2: return 2000;
      case 3: return 3000;
      case 4: return 4000;
      case 5: return 5000;
      default: return 5000;
    }
  }
}