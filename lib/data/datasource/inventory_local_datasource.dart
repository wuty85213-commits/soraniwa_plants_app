import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';

class InventoryLocalDataSource {
  final log = AppLogger.tag("InventoryLocalDataSource📁");
  final Box<InventoryEntity> _box;
  InventoryLocalDataSource(this._box);

  List<InventoryEntity> getAll() => _box.values.toList();

  Future<void> put(InventoryEntity entity) async {
      await _box.put(entity.id, entity);
      log.d('id: ${entity.itemId},quantity: ${entity.quantity} セーブしました');
  }

  Future<void> delete(String id) async => await _box.delete(id);

  Future<void> clear() => _box.clear();
}