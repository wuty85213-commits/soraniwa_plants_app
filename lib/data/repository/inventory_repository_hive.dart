import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/datasource/inventory_local_datasource.dart';
import 'package:myplantapp_ver1/domain/mappers.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/repository/i_inventory_repository.dart';

/// Hive上で動作する Inventory（所持アイテム）リポジトリ
class InventoryRepository implements IInventoryRepository {
  final InventoryLocalDataSource _local;

  InventoryRepository(this._local);
  final log = AppLogger.tag("InventoryRepo📁");

  /// 全アイテム取得
  @override
  List<Inventory> getAll() => _local.getAll().map((e) => e.toDomain()).toList();

  /// 特定アイテムを検索（IDとVariant／Attributeを考慮）
  @override
  Inventory? findItem(int itemId, Variant? variant, Attribute? attribute) {
    final result =  getAll().firstWhereOrNull(
          (i) =>
      i.itemId == itemId &&
          (variant == null || i.variant == variant) &&
          (attribute == null || i.attribute == attribute)
    );
    if(result == null) {
      log.w('⚠️ Inventoryにアイテム(id=$itemId)が見つかりません');
    }
    return result;
  }

  @override
  List<Inventory> getSeedItems() => getAll().where(
          (i) => i.itemType == ItemType.seed).toList();

  @override
  List<Inventory> getFertilizerItems() => getAll().where(
      (i) => i.itemType == ItemType.growthBoost ||
      i.itemType == ItemType.rarerateboostHigh ||
      i.itemType == ItemType.rarerateboostRow ||
      i.itemType == ItemType.rarerateboostSuper)
      .toList();

  @override
  Future<void> save(Inventory inventory) async {
    final entity = inventory.toEntity();
    if(entity.quantity == 0){
      await _local.delete(entity.id);
      log.d('インベントリデータを削除しました(itemId: ${entity.itemId})');
    } else {
      await _local.put(entity);
    }
  }
  /*
  @override
  Future<void> addItem(
      int itemId,
      ItemType itemType,
      Variant? variant,
      Attribute? attribute,
      int quantity
      ) async {

    final item = getAll().firstWhereOrNull((p) => p.itemId == itemId);
    if (item != null) {

      await item.save();
      log.i('🪙 既存アイテム(${itemId})に+$quantity追加');
    } else {
      final newItem = InventoryEntity(
        itemId: itemId,
        itemType: itemType,
        variant: variant,
        attribute: attribute,
        quantity: quantity,
      );
      await _box.put(newItem.id, newItem);
      log.i('🎁 新規アイテム(${itemId})を追加');
    }
  }

  /// アイテムを消費（足りない場合はfalseを返す）
  @override
  Future<bool> removeItem(int itemId, int quantity) async {

    final item = _box.values.firstWhereOrNull((i) =>i.itemId == itemId);
    if (item == null) return false;

    item.quantity -= quantity;

    if (item.quantity <= 0) {
      await item.delete();
      log.i('🗑️ アイテム(${itemId})を削除');
    } else {
      await item.save();
    }
    return true;
  }

   */

  /// 全データ削除（リセット）
  @override
  Future<void> clearAll() async {
    await _local.clear();
    log.i('⚠️ 所持品データを全削除しました');
  }
}