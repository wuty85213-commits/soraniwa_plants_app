import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';

part 'farm_state.freezed.dart';

@freezed
class FarmState with _$FarmState {
  const factory FarmState({
    @Default([]) List<UserPlant> userPlants,
  }) = _FarmState;
}