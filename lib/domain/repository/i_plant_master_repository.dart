import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';

abstract class IPlantMasterRepository {
  Future<void> loadAll({String localeCode = 'ja'});
  List<PlantMasterEntity> getAll();
  List<PlantMasterEntity> getNormalPlant();
  PlantMasterEntity? findById(int id);
  findByIdAndVariant(int id, Variant variant);
  Future<void> reloadFromJson({String localeCode = 'ja'}); // デバッグ・再読み込み用
}