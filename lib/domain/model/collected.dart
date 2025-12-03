import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';

part 'collected.freezed.dart';

@freezed
class Collected with _$Collected {
  const factory Collected({
    required String id,
    required int plantId,
    required Variant variant,
    required Attribute attribute,
    required int harvestCount,
    required int lastHarvestedAt,
  }) = _Collected;
}
