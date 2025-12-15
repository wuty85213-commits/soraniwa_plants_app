import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/data/datasource/user_local_datasource.dart';
import 'package:myplantapp_ver1/domain/mappers.dart';
import 'package:myplantapp_ver1/domain/model/pot.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_repository.dart';

/// Hive上で動作する User リポジトリ
class UserRepository implements IUserRepository {
  final UserLocalDataSource _local;

  UserRepository(this._local);
  final log = AppLogger.tag("UserRepo📁");

  /// 現在のユーザーを取得（常に1ユーザー想定）
  @override
  User getUser() {
    return _local.getUser().toDomain();
  }

  @override
  Future <List<Pot>> potGetAll() async{
    final list = await _local.potGetAll();
    return list.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> save(User user) async {
    log.d('save 起動!');
    final entity = user.toEntity();
    await _local.put(entity);
    log.d('${user.coins}');
  }

  @override
  Future<void> potSave(Pot pot) async {
    final entity = pot.toEntity();
    await _local.potPut(entity);
  }

  /// 全データ削除
  @override
  Future<void> resetAllData() async {
    await _local.clear();
    await _local.potClear();
    log.i('⚠️ ユーザーデータを全削除しました');
  }
}