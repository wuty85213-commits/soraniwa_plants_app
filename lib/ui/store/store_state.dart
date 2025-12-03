import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';

part 'store_state.freezed.dart';

@freezed
class StoreState with _$StoreState {
  const factory StoreState({
    required User user,
    @Default([]) List<ItemMasterEntity> displayableItems,
    @Default([]) List<PlantMasterEntity> plantMasters,
    @Default([]) List<ItemMasterEntity> itemsMasters,
  }) = _StoreState;
}