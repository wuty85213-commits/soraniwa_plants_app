import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';

part 'collected_state.freezed.dart';

@freezed
class CollectedState with _$CollectedState {
  const factory CollectedState({
    @Default([]) List<Collected> collected,
    @Default([]) List<PlantMasterEntity> normalPlants,
    @Default([]) List<PlantMasterEntity> plants,
    @Default([]) List<ItemMasterEntity> items,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _CollectedState;
}