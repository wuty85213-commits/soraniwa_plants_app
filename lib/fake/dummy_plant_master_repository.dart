import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/repository/i_plant_master_repository.dart';

class DummyPlantMasterRepository implements IPlantMasterRepository {
  const DummyPlantMasterRepository();

  @override
  Future<void> loadAll({String localeCode = 'ja'}) async {}

  @override
  List<PlantMasterEntity> getAll() => const [];

  @override
  List<PlantMasterEntity> getNormalPlant() => const [];

  @override
  PlantMasterEntity? findById(int id) => null;

  @override
  findByIdAndVariant(int id, Variant variant) => null;

  @override
  Future<void> reloadFromJson({String localeCode = 'ja'}) async {}
}