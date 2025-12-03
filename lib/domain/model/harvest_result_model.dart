import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';

class HarvestResult{
  final PlantMasterEntity plant;
  final ItemMasterEntity item;
  final int coins;
  final int seeds;

  HarvestResult({
    required this.plant,
    required this.item,
    required this.coins,
    required this.seeds,
});
}