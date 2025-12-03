import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';

class InventoryLocalDataSource {
  final Box<InventoryEntity> _box;
  InventoryLocalDataSource(this._box);

  List<InventoryEntity> getAll() => _box.values.toList();

  Future<void> put(InventoryEntity entity) async =>
      await _box.put(entity.id, entity);

  Future<void> delete(String id) async => await _box.delete(id);

  Future<void> clear() => _box.clear();
}