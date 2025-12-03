import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:uuid/uuid.dart';

part 'user_plant_entity.g.dart';

@HiveType(typeId: 11)
class UserPlantEntity extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int plantId;

  @HiveField(2)
  Variant variant;

  @HiveField(3)
  double progress;

  @HiveField(4)
  int growthBoost;

  @HiveField(5)
  int lastWatered;

  @HiveField(6)
  int lastUpdate;

  @HiveField(7)
  PlantCondition plantCondition;

  @HiveField(8)
  int slotIndex;

  UserPlantEntity({
    String? id,
    required this.plantId,
    required this.variant,
    required this.progress,
    required this.growthBoost,
    required this.lastWatered,
    required this.lastUpdate,
    required this.plantCondition,
    required this.slotIndex,
  }) : id = id ?? const Uuid().v4();
}

