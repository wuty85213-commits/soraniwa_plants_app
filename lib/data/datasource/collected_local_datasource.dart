import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/data/entity/collected_entity.dart';

class CollectedLocalDataSource {
  final log = AppLogger.tag("CollectedDataSource📁");
  final Box<CollectedEntity> _box;
  CollectedLocalDataSource(this._box);

  List<CollectedEntity> getAll() => _box.values.toList();

  Future<void> put(CollectedEntity entity) async{
    _box.put(entity.id, entity);
    log.d('id: ${entity.plantId},variant: ${entity.variant} セーブしました');
  }

  Future<void> delete(String id) async => _box.delete(id);

  Stream<List<CollectedEntity>> watchAll() async* {
    yield _box.values.toList();
    await for (final _ in _box.watch()) {
      yield _box.values.toList();
    }
  }

  Future<void> clear() => _box.clear();
}