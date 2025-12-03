import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';
import 'package:myplantapp_ver1/domain/repository/i_collected_repository.dart';

class DummyCollectedRepository implements ICollectedRepository {
  const DummyCollectedRepository();

  @override
  List<Collected> getAll() => const [];

  @override
  Collected? find(int plantId, Variant variant) => null;

  @override
  Future<void> save(Collected collected) async {}

  @override
  Future<void> remove(int plantId, Variant variant) async {}

  @override
  Future<void> clearAll() async {}

  @override
  Stream<List<Collected>> watchAll() => const Stream.empty();
}