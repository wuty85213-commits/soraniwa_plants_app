import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';

part 'inventory.freezed.dart';

@freezed
class Inventory with _$Inventory {
  const factory Inventory({
    required String id,
    required int itemId,
    required ItemType itemType,
    Variant? variant,
    Attribute? attribute,
    required int quantity,
  }) = _Inventory;
}