import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/ui/farm/farm_notifier.dart';

part 'user_plant.freezed.dart';

@freezed
class UserPlant with _$UserPlant {
  const factory UserPlant({
    required String id,
    required int plantId,
    required Variant variant,
    required double progress,
    required int growthBoost,
    required int lastWatered,
    required int lastUpdate,
    required PlantCondition plantCondition,
    required int slotIndex,
  }) = _UserPlant;
}

extension GetStage on UserPlant {
  int get stage {
    final p = progress; // UserPlant.progress (double 0〜1)
    if (p < 0.33) return 0;
    if (p < 0.66) return 1;
    if (p < 1.0) return 2;
    return 3;
  }
}