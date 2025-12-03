import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/data/entity/pot_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_entity.dart';
import 'package:uuid/uuid.dart';

class UserLocalDataSource {
  final log = AppLogger.tag("UserDataSource📁");
  final uuid = Uuid();
  final Box<UserEntity> _box;
  final Box<PotEntity> _potBox;
  UserLocalDataSource(this._box,this._potBox);

  UserEntity getUser() {
    if(_box.isEmpty){
      final user = UserEntity(
        userKey: "LOCAL_USER",
        coins: 0,
        unlockedSlots: 1,
        actionFlags: [],
        rewardFlags: [],
      );
      put(user);
      log.i('✅ 新規ユーザーを作成しました');

      final pot = PotEntity(slotIndex: 0);
      potPut(pot);
      log.i('初期ポットを追加しました! itemId:${pot.itemId}');

    }
    return _box.values.first;
  }

  Future<void> put(UserEntity entity) async =>
      _box.put(entity.id, entity);

  Future<void> delete(String id) async => _box.delete(id);

  Stream<List<UserEntity>> watchAll() async* {
    yield _box.values.toList();
    await for (final _ in _box.watch()) {
      yield _box.values.toList();
    }
  }

  Future<void> clear() => _box.clear();

  Future<List<PotEntity>> potGetAll() async {
    if(_potBox.isEmpty){
      final pot = PotEntity(id: uuid.v4(),slotIndex: 1);
      await potPut(pot);
    }
    return _potBox.values.toList();
  }

  Future<void> potPut(PotEntity entity) async =>
      _potBox.put(entity.id, entity);

  Future<void> potDelete(String id) async => _box.delete(id);

  Future<void> potClear() => _potBox.clear();
}