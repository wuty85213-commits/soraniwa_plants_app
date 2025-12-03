import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';

part 'master_data_state.freezed.dart';

@freezed
class MasterDataState with _$MasterDataState {
  const factory MasterDataState({
    @Default([]) List<PlantMasterEntity> plants,
    @Default([]) List<ItemMasterEntity> items,
    @Default(false) bool loading,
    String? error,
  }) = _MasterDataState;
}