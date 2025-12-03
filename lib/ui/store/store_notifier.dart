import 'dart:math';

import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_state.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:myplantapp_ver1/ui/master/master_data_state.dart';
import 'package:myplantapp_ver1/ui/store/store_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_notifier.g.dart';

@riverpod
class StoreNotifier extends _$StoreNotifier {
  final log = AppLogger.tag("StoreNotifier🏆");

  late final UserState _userState;
  late final MasterDataState _masterData;
  late final List<Inventory> _inventory;

  bool _listenRegistered = false;

  @override
  Future<StoreState> build() async {
    print("🔥 StoreNotifier build()");
    _userState = await ref.read(userNotifierProvider.future);
    _masterData = await ref.read(masterDataNotifierProvider.future);
    _inventory = await ref.read(inventoryNotifierProvider.future);

    _setupInventoryListenOnce();

    final displayItems = getDisplayableItems(
        _userState.user,
        _masterData.items,
        _inventory
    );
    return StoreState(
      user: _userState.user,
      displayableItems: displayItems,
      plantMasters: _masterData.plants,
      itemsMasters: _masterData.items,
    );

  }

  void _setupInventoryListenOnce() {
    if (_listenRegistered) return;
    _listenRegistered = true;

    log.d("🔥 StoreNotifier listen 設定");

    ref.listen<AsyncValue<List<Inventory>>>(
      inventoryNotifierProvider,
          (previous, next) async {
        next.whenData((inventory) async {
          log.d("🟢 inventory 変更 → displayableItems のみ更新");

          final current = state.value;
          if (current == null) {
            log.e("❌ state.value が null なので更新できません");
            return;
          }

          // displayableItems だけ再作成
          final updatedDisplayItems = getDisplayableItems(
            current.user,          // 既存の user
            current.itemsMasters,  // 既存の master
            inventory,             // 更新された inventory
          );

          // displayableItems のみ更新した新 state を返す
          state = AsyncData(
            current.copyWith(
              displayableItems: updatedDisplayItems,
            ),
          );
        });
      },
    );
  }

  /// 表示可能な商品一覧を取得（販売条件付き）
  List<ItemMasterEntity> getDisplayableItems(
      User user,
      List<ItemMasterEntity> list,
      List<Inventory> inventoryList
      ) {

    final displayable = <ItemMasterEntity>[];

    for (final item in list) {
      if (item.itemType == ItemType.seed &&
          (item.variant == Variant.GOLD || item.variant == Variant.RAINBOW)) {
        continue;
      }

      if (!_canDisplaySeed(item, user)) continue;

      //達成報酬限定の鉢
      if (item.id == 500 || item.id == 501 || item.id == 502 || item.id == 509 ) {
        continue;
      }

      final inventory = inventoryList.firstWhereOrNull((inv) => inv.itemId == item.id);
      if (!_canDisplayCategory(item, user, inventory)) continue;
      displayable.add(item);
      log.d('getDisplay itemId${item.id},${item.itemType},${item.attribute}');
    }


    return displayable;
  }

  /// カテゴリ別の表示条件
  bool _canDisplayCategory(ItemMasterEntity item, User user, Inventory? inventory) {
    switch (item.itemType) {
      case ItemType.decoration:
        final owned = inventory?.quantity ?? 0;
        return owned == 0;
      case ItemType.growthBoost:
        return true;
      default:
        return true;
    }
  }

  bool _canDisplaySeed(ItemMasterEntity item, User user){
    switch(item.attribute) {
      case Attribute.bloom :
        return user.rewardFlags.contains('ACH_Leafy');
      case Attribute.tree :
        return user.rewardFlags.contains('ACH_Bloom');
      case Attribute.fun :
        return user.rewardFlags.contains('ACH_Tree');
      case Attribute.odd :
        return user.rewardFlags.contains('ACH_Fun');
      default:
        return true;
    }
  }

  /// 購入処理
  Future<bool> buyItem({required int itemId, int quantity = 1}) async {
    final ivNf = ref.read(inventoryNotifierProvider.notifier);
    final userNf = ref.read(userNotifierProvider.notifier);

    final masterData = ref.read(masterDataNotifierProvider.notifier);
    final item = masterData.findItemById(itemId);
    if (item == null) return false;

    final userState = await ref.read(userNotifierProvider.future);
    final user = userState.user;

    final totalCost = item.price * quantity;
    if (user.coins < totalCost) return false;

    await userNf.reduceCoin(totalCost);
    await ivNf.addItem(itemId, quantity);

    log.i("🛒 ${item.name} を購入しました (-$totalCost G)");
    return true;
  }

  /// 販売処理
  Future<bool> sellItem({required int itemId, int quantity = 1}) async {
    final masterData = await ref.read(masterDataNotifierProvider.notifier);
    final masterItem = masterData.findItemById(itemId);
    if (masterItem == null) return false;

    final userNf = ref.read(userNotifierProvider.notifier);
    final ivNf = ref.read(inventoryNotifierProvider.notifier);

    final reduceItem = await ivNf.reduceItem(itemId, quantity);
    if(reduceItem != true) return false;

    final totalGain = (masterItem.itemType == ItemType.seed)
        ? 5 * quantity
        : (masterItem.price ~/ 2) * quantity;

    await userNf.addCoin(totalGain);

   log.i("💰 ${masterItem.name} を売却しました (+$totalGain G)");
    return true;
  }

  Future<int> adReward() async {
    final inNf = ref.read(inventoryNotifierProvider.notifier);
    final n = Random().nextInt(100);

    // 1次抽選（大分類）
    final baseReward = switch (n) {
      < 1  => 0,   // 1% 金の種カテゴリ
      < 5  => 401, // 4% 幸運の肥料
      < 20 => 302, // 15% 固定肥料DX
      < 50 => 301, // 30% 固定肥料
      _    => 201, // 50% 成長促進剤
    };

    // 金の種の場合のみ 2次抽選
    if (baseReward == 0) {
      final g = Random().nextInt(5);

      final seedReward = switch (g) {
        0 => 102, // Leafy
        1 => 105, // Bloom
        2 => 108, // Tree
        3 => 111, // Fun
        _ => 114, // Odd
      };

      await inNf.addItem(seedReward, 1);
      return seedReward;
    }

    // そのまま付与
    await inNf.addItem(baseReward, 1);
    return baseReward;
  }
}