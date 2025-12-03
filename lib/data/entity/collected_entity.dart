import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:uuid/uuid.dart';

part 'collected_entity.g.dart';

@HiveType(typeId: 13)
class CollectedEntity extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int plantId;

  @HiveField(2)
  Variant variant;

  @HiveField(3)
  Attribute attribute;

  @HiveField(4)
  int harvestCount;

  @HiveField(5)
  int lastHarvestedAt;

  CollectedEntity({
    String? id,
    required this.plantId,
    required this.variant,
    required this.attribute,
    required this.harvestCount,
    required this.lastHarvestedAt,
  }) : id = id ?? const Uuid().v4();
}