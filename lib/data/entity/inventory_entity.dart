import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:uuid/uuid.dart';

part 'inventory_entity.g.dart';

@HiveType(typeId: 12)
class InventoryEntity extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int itemId;

  @HiveField(2)
  ItemType itemType;

  @HiveField(3)
  Variant? variant;

  @HiveField(4)
  Attribute? attribute;

  @HiveField(5)
  int quantity;

  InventoryEntity({
    String? id,
    required this.itemId,
    required this.itemType,
    this.variant,
    this.attribute,
    required this.quantity,
  }) : id = id ?? const Uuid().v4();
}
