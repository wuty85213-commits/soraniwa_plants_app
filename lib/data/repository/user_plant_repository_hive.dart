import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/data/datasource/user_plant_local_datasource.dart';
import 'package:myplantapp_ver1/domain/mappers.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_plant_repository.dart';

/// 🪴 Hive版 UserPlantRepository（データ操作のみ）
class UserPlantRepository implements IUserPlantRepository {
  final UserPlantLocalDataSource _local;

  UserPlantRepository(this._local);

  final log = AppLogger.tag("UserPlantRepo📁");

  @override
  List<UserPlant> getAllUserPlants() =>
      _local.getAll().map((e) => e.toDomain()).toList();

  @override
  int? getAvailableSlot(int maxSlots) {
    final used = getAllUserPlants().map((e) => e.slotIndex).toSet();
    for (int i = 0; i < maxSlots; i++) {
      if (!used.contains(i)) return i;
    }
    return null;
  }

  @override
  Future<void> addPlant(UserPlant entity) async {
    final exists = getAllUserPlants().any((p) => p.slotIndex == entity.slotIndex);
    if(exists) {
      log.e('⚠️ Slot ${entity.slotIndex} は既に使用されているため、追加を中断しました');
      return;
    }
    await _local.put(entity.toEntity());
    log.i('✅ 植物の追加完了: id=${entity.id}, slot=${entity.slotIndex}');
  }

  @override
  Future<void> removePlant(dynamic id) async {
    log.d('removePlant 起動');
    await _local.delete(id);
    log.d('removePlant 完了! (${id}削除)');
  }

  @override
  UserPlant? findBySlotIndex(int slotIndex) {
    return getAllUserPlants().firstWhereOrNull(
          (e) => e.slotIndex == slotIndex
    );
  }

  @override
  Future<void> save(UserPlant userPlant) async {
    final entity = userPlant.toEntity();
    await _local.put(entity);
  }

  @override
  Future<void> clearAll() async {
    await _local.clear();
  }
}