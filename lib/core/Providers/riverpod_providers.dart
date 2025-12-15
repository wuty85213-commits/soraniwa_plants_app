import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/env.dart';
import 'package:myplantapp_ver1/core/hive/hive_box_maneger.dart';
import 'package:myplantapp_ver1/data/datasource/collected_local_datasource.dart';
import 'package:myplantapp_ver1/data/datasource/inventory_local_datasource.dart';
import 'package:myplantapp_ver1/data/datasource/user_local_datasource.dart';
import 'package:myplantapp_ver1/data/datasource/user_plant_local_datasource.dart';
import 'package:myplantapp_ver1/data/entity/collected_entity.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/pot_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_plant_entity.dart';
import 'package:myplantapp_ver1/data/repository/collected_repository_hive.dart';
import 'package:myplantapp_ver1/data/repository/inventory_repository_hive.dart';
import 'package:myplantapp_ver1/data/repository/item_master_repository_hive.dart';
import 'package:myplantapp_ver1/data/repository/plant_master_repository.dart';
import 'package:myplantapp_ver1/data/repository/user_plant_repository_hive.dart';
import 'package:myplantapp_ver1/data/repository/user_repository_hive.dart';
import 'package:myplantapp_ver1/domain/model/achievement_list.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/domain/repository/i_collected_repository.dart';
import 'package:myplantapp_ver1/domain/repository/i_inventory_repository.dart';
import 'package:myplantapp_ver1/domain/repository/i_item_master_repository.dart';
import 'package:myplantapp_ver1/domain/repository/i_plant_master_repository.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_plant_repository.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_repository.dart';

final log_RP = AppLogger.tag("Riverpod_Provider🚀");

final hiveInitProvider = FutureProvider<void>((ref) async {
  await HiveBoxManager.init(); // ← Hive.initFlutter + env dir設定

  //await HiveBoxManager.resetAll(); //実機テスト用

  await Future.wait([
    HiveBoxManager.openBox<UserEntity>('userBox'),
    HiveBoxManager.openBox<PotEntity>('potBox'),
    HiveBoxManager.openBox<UserPlantEntity>('userPlantBox'),
    HiveBoxManager.openBox<InventoryEntity>('inventoryBox'),
    HiveBoxManager.openBox<CollectedEntity>('collectedBox'),
    HiveBoxManager.openBox<PlantMasterEntity>('plantMasterBox'),
    HiveBoxManager.openBox<ItemMasterEntity>('itemMasterBox'),
    HiveBoxManager.openBox('rewardBox'),
  ]);
});

// -------------------------
// Hive Box Providers
// -------------------------

final userBoxProvider = FutureProvider<Box<UserEntity>>((ref) async {
  return Hive.box<UserEntity>('userBox_${EnvConfig.flavor}');
});

final potBoxProvider = FutureProvider<Box<PotEntity>>((ref) async {
  return Hive.box<PotEntity>('potBox_${EnvConfig.flavor}');
});

final userPlantBoxProvider = FutureProvider<Box<UserPlantEntity>>((ref) async {
  return Hive.box<UserPlantEntity>('userPlantBox_${EnvConfig.flavor}');
});

final inventoryBoxProvider = FutureProvider<Box<InventoryEntity>>((ref) async {
  return Hive.box<InventoryEntity>('inventoryBox_${EnvConfig.flavor}');
});

final collectedBoxProvider = FutureProvider<Box<CollectedEntity>>((ref) async {
  return Hive.box<CollectedEntity>('collectedBox_${EnvConfig.flavor}');
});

final plantBoxProvider = FutureProvider<Box<PlantMasterEntity>>((ref) async {
  return Hive.box<PlantMasterEntity>('plantMasterBox_${EnvConfig.flavor}');
});

final itemBoxProvider = FutureProvider<Box<ItemMasterEntity>>((ref) async {
  return Hive.box<ItemMasterEntity>('itemMasterBox_${EnvConfig.flavor}');
});

// -------------------------
// Repository Providers
// -------------------------

final userRepositoryProvider =
FutureProvider<IUserRepository>((ref) async {
  final box = await ref.watch(userBoxProvider.future);
  final potBox = await ref.watch(potBoxProvider.future);
  return UserRepository(UserLocalDataSource(box,potBox));
});

final userPlantRepositoryProvider =
FutureProvider<IUserPlantRepository>((ref) async {
  final box = await ref.watch(userPlantBoxProvider.future);
  return UserPlantRepository(UserPlantLocalDataSource(box));
});

final inventoryRepositoryProvider =
FutureProvider<IInventoryRepository>((ref) async {
  final box = await ref.watch(inventoryBoxProvider.future);
  return InventoryRepository(InventoryLocalDataSource(box));
});

final collectedRepositoryProvider =
FutureProvider<ICollectedRepository>((ref) async {
  final box = await ref.watch(collectedBoxProvider.future);
  return CollectedRepository(CollectedLocalDataSource(box));
});

final plantMasterRepositoryProvider =
FutureProvider<IPlantMasterRepository>((ref) async {
  final box = await ref.watch(plantBoxProvider.future);
  return PlantMasterRepositoryHive(box);
});

final itemMasterRepositoryProvider =
  FutureProvider<IItemMasterRepository>((ref) async {
  final box = await ref.watch(itemBoxProvider.future);
  return ItemMasterRepositoryHive(box);
});

// -------------------------
// AchievementList
// -------------------------
final achievementListProvider = Provider<List<Achievement>>((ref) {
  return achievementList;
});
