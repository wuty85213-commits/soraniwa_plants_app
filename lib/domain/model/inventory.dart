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

extension GetQuantity on Inventory {
  int get QtyFormatted {
    final value = quantity;

    if (value >= 1000) {
      int m = 999;
      return m;
    }
    return value;
  }
}