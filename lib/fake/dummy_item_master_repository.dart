import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/domain/repository/i_item_master_repository.dart';

class DummyItemMasterRepository implements IItemMasterRepository {
  const DummyItemMasterRepository();

  @override
  Future<void> loadAll({String localeCode = 'ja'}) async {}

  @override
  List<ItemMasterEntity> getAll() => const [];

  @override
  ItemMasterEntity? findById(int id) => null;

  @override
  Future<void> reloadFromJson({String localeCode = 'ja'}) async {}
}