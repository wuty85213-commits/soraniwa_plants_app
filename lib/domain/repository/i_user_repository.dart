import 'package:myplantapp_ver1/domain/model/pot.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';

abstract class IUserRepository {
  User getUser();
  Future<List<Pot>> potGetAll();
  Future<void> save(User user);
  Future<void> potSave(Pot pot);
  Future<void> resetAllData();
}