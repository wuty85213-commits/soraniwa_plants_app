///現在、使用していない!!

import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/repository/i_item_master_repository.dart';
import 'package:myplantapp_ver1/domain/repository/i_plant_master_repository.dart';
import 'package:myplantapp_ver1/fake/dummy_item_master_repository.dart';
import 'package:myplantapp_ver1/fake/dummy_plant_master_repository.dart';

/// MasterDataCache（Repository版）
///
/// 各マスター（Plant / Item）のRepositoryを注入し、
/// アプリ全体で統一的にマスターデータを管理。

class MasterDataCache {
  final IPlantMasterRepository _plantRepo;
  final IItemMasterRepository _itemRepo;
  bool _initialized = false;

  MasterDataCache({
    required IPlantMasterRepository plantRepo,
    required IItemMasterRepository itemRepo,
  })  : _plantRepo = plantRepo,
        _itemRepo = itemRepo;

  final log = AppLogger.tag("MaterDataCache📚");
  bool get isInitialized => _initialized;

  Future<void> loadAll() async {
    if (_initialized) {
      log.d('ℹ️ すでに初期化済みのためスキップ');
      return;
    }

    try {
      await Future.wait([
        _plantRepo.loadAll(),
        _itemRepo.loadAll(),
      ]);
      _initialized = true;
      log.i('✅ 全マスター読み込み完了');
    } catch (e, st) {
      _initialized = false;
      log.e('❌ ロード失敗 → $e\n$st');
      rethrow;
    }
  }

  List<PlantMasterEntity> get plants => _plantRepo.getAll();
  List<PlantMasterEntity> get normalPlants => _plantRepo.getNormalPlant();
  List<ItemMasterEntity> get items => _itemRepo.getAll();

  PlantMasterEntity? findPlantById(int id) => _plantRepo.findById(id);
  PlantMasterEntity? findPlantByIdAndVariant(int id, Variant variant) =>
      _plantRepo.findByIdAndVariant(id, variant);
  ItemMasterEntity? findItemById(int id) => _itemRepo.findById(id);

  static MasterDataCache empty() {
    return MasterDataCache(
      plantRepo: DummyPlantMasterRepository(),
      itemRepo: DummyItemMasterRepository(),
    );
  }

  Future<void> reloadAll() async {
    await Future.wait([
      _plantRepo.reloadFromJson(),
      _itemRepo.reloadFromJson(),
    ]);
    _initialized = true;
    log.i('♻️ 全マスターを再読み込みしました');
  }
}