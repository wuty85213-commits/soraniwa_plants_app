import 'package:myplantapp_ver1/core/config/result.dart';
import 'package:myplantapp_ver1/data/entity/user_plant_entity.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';

abstract class IUserPlantRepository {

  List<UserPlant> getAllUserPlants();
  int? getAvailableSlot(int maxSlots);
  Future<void> addPlant(UserPlant entity);
  Future<void> removePlant(dynamic id);
  UserPlant? findBySlotIndex(int slotIndex);
  Future<void> save(UserPlant userPlant);
  Future<void> clearAll();

}