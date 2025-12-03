import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/data/entity/user_plant_entity.dart';

class UserPlantLocalDataSource {
  final Box<UserPlantEntity> _box;
  UserPlantLocalDataSource(this._box);

  List<UserPlantEntity> getAll() => _box.values.toList();


  Future<void> put(UserPlantEntity entity) async =>
      _box.put(entity.id, entity);

  Future<void> delete(String id) async => _box.delete(id);

  Future<void> clear() => _box.clear();
}