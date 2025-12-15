import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';

abstract class ICollectedRepository {
  List<Collected> getAll();
  Collected? find(int plantId, Variant variant);
  Future<void> save(Collected collected);
  Future<void> remove(int plantId, Variant variant);
  Future<void> clearAll();
  Stream<List<Collected>> watchAll();
}