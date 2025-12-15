import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod_providers.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/item_amount.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'inventory_notifier.g.dart';

@riverpod
class InventoryNotifier extends _$InventoryNotifier {
  final log = AppLogger.tag("inventoryNotifier");
  final uuid = Uuid();

  @override
  Future<List<Inventory>> build() async {
    final repo = await ref.read(inventoryRepositoryProvider.future);
    return repo.getAll();
  }

  Future<void> save(Inventory inventory) async {
    final repo = await ref.read(inventoryRepositoryProvider.future);
    await repo.save(inventory);

    final updatedList = await repo.getAll();
    state = AsyncData(updatedList);
  }

  Future<bool> addItem(int itemId, int quantity) async{
    final repo = await ref.read(inventoryRepositoryProvider.future);
    final inventoryList = await future;
    final masterData = await ref.read(masterDataNotifierProvider.notifier);

    final masterItem = await masterData.findItemById(itemId);
    if (masterItem == null) {
      log.e('❌ マスタデータが存在しませんでした');
      return false;
    }

    final existing = inventoryList.firstWhereOrNull((p) => p.itemId == itemId);
    if(existing != null) {
      final updated = existing.copyWith(
        quantity: existing.quantity + quantity,
      );
      await save(updated);
    } else {
      final newItem = Inventory(
          id: uuid.v4(),
          itemId: masterItem.id,
          itemType: masterItem.itemType,
          variant: masterItem.variant,
          attribute: masterItem.attribute,
          quantity: quantity
      );
      save(newItem);
    }
    final updatedList = await repo.getAll();
    state = AsyncData(updatedList);
    return true;
  }

  Future<bool> addItems(List<ItemAmount> items) async {
    final repo = await ref.read(inventoryRepositoryProvider.future);
    final inventoryList = await future;
    final masterData = ref.read(masterDataNotifierProvider.notifier);

    bool success = true;

    for (final item in items) {
      final masterItem = await masterData.findItemById(item.itemId);

      if (masterItem == null) {
        log.e('❌ マスタデータが存在しませんでした: id=${item.itemId}');
        success = false;
        continue;
      }

      final existing = inventoryList.firstWhereOrNull((p) => p.itemId == item.itemId);

      if (existing != null) {
        // 更新
        final updated = existing.copyWith(
          quantity: existing.quantity + item.quantity,
        );
        await repo.save(updated);
      } else {
        // 新規追加
        final newItem = Inventory(
          id: uuid.v4(),
          itemId: masterItem.id,
          itemType: masterItem.itemType,
          variant: masterItem.variant,
          attribute: masterItem.attribute,
          quantity: item.quantity,
        );
        await repo.save(newItem);
      }
    }

    final updatedList = await repo.getAll();
    state = AsyncData(updatedList);

    return success;
  }

  Future<bool> reduceItem(int itemId, int quantity) async{
    log.e('reduceItem 起動');
    final repo = await ref.read(inventoryRepositoryProvider.future);
    final inventoryList = await future;
    final masterData = await ref.read(masterDataNotifierProvider.notifier);

    final masterItem = await masterData.findItemById(itemId);
    if (masterItem == null) {
      log.e('❌ マスタデータが存在しませんでした');
      return false;
    }

    final existing = inventoryList.firstWhereOrNull((p) => p.itemId == itemId);
    if(existing == null) {
      log.e('❌ インベントリにアイテムが存在しません');
      return false;
    }

    if(existing.quantity < quantity){
      log.e('❌ アイテムの数量が不足しています: 所持数${existing.quantity} < 購入数${quantity}');
      return false;
    }

    final updated = existing.copyWith(
      quantity: existing.quantity - quantity,
    );
    await save(updated);
    final updatedList = await repo.getAll();
    state = AsyncData(updatedList);

    log.e('reduceItem 完了');
    return true;
  }

  Future<bool> reduceItems(List<ItemAmount> items) async {
    log.d('reduceItems 起動: ${items.length}件');

    final repo = await ref.read(inventoryRepositoryProvider.future);
    final inventoryList = await future;
    final masterData = await ref.read(masterDataNotifierProvider.notifier);

    // 🔍 (1) 全アイテムが減らせるか事前チェック
    for (final item in items) {
      final masterItem = await masterData.findItemById(item.itemId);
      if (masterItem == null) {
        log.e('❌ マスタデータが存在しません: itemId=${item.itemId}');
        return false;
      }

      final inv = inventoryList.firstWhereOrNull((p) => p.itemId == item.itemId);
      if (inv == null) {
        log.e('❌ インベントリに存在しません: itemId=${item.itemId}');
        return false;
      }

      if (inv.quantity < item.quantity) {
        log.e('❌ 数量不足: itemId=${item.itemId}, 所持${inv.quantity} < 必要${item.quantity}');
        return false;
      }
    }

    // 🔧 (2) すべてOK → 実際に減算
    for (final item in items) {
      final inv = inventoryList.firstWhere((p) => p.itemId == item.itemId);
      final updated = inv.copyWith(
        quantity: inv.quantity - item.quantity,
      );
      await save(updated);
      log.d('✔ 減算: itemId=${item.itemId}, -${item.quantity}');
    }

    // 🔄 (3) state を更新
    final updatedList = await repo.getAll();
    state = AsyncData(updatedList);

    log.d('reduceItems 完了');
    return true;
  }
}