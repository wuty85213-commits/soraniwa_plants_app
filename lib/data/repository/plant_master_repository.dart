import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/repository/i_plant_master_repository.dart';

class PlantMasterRepositoryHive implements IPlantMasterRepository {
  final Box<PlantMasterEntity> _box;
  bool _loaded = false;
  List<PlantMasterEntity> _cache = [];

  PlantMasterRepositoryHive(this._box);
  final log = AppLogger.tag("PlantMasterRepo🌱");

  @override
  Future<void> loadAll({String localeCode = 'ja'}) async {
    if (_loaded) {
      log.w('⚠️ マスタデータはロード済みです');
      return;
    }

    if (_box.isNotEmpty) {
      _cache = _box.values.toList();
      _loaded = true;
      log.i('ℹ️ PlantMasterRepositoryHive: 既存Hiveデータを利用しました');
      return;
    }
    // ✅ Hiveが空なら assets JSON からロード
    log.d('🌱 Loading Plant Master from JSON (locale: $localeCode)...');

    try{
      final path = 'assets/plants_$localeCode.json';
      final jsonString = await rootBundle.loadString(path);
      final data = json.decode(jsonString) as List<dynamic>;

      final plants = data
          .map((e) => PlantMasterEntity.fromJson(e as Map<String, dynamic>))
          .toList();

      for (final plant in plants) {
        final key = "${plant.id}_${plant.variant.name}";
        await _box.put(key, plant);
      }

      _cache = plants;
      _loaded = true;
      log.i('✅ JSONから初期ロード完了 (${plants.length}件)');
    } catch(e,st){
      log.e('❌ JSONロード中にエラー → $e\n$st');
      rethrow;
    }
  }

  /// 言語切り替え対応
  Future<void> reloadFromJson({String localeCode = 'ja'}) async {
    try {
      await _box.clear();
      _cache.clear();
      _loaded = false;
      await loadAll(localeCode: localeCode);
      log.i('♻️ JSON(${localeCode})から再ロードしました');
    } catch (e, st) {
      log.e('❌ 再ロード中にエラー → $e\n$st');
    }
  }

  @override
  List<PlantMasterEntity> getAll() => _cache;

  @override
  List<PlantMasterEntity> getNormalPlant() =>
      _cache.where((p) => p.variant == Variant.NORMAL).toList();

  @override
  PlantMasterEntity? findById(int id) {
    //NORMAL優先(なければランダム)
    try {
      return _cache.firstWhere((p) => p.id == id && p.variant == Variant.NORMAL,
      orElse: () => _cache.firstWhere((p) => p.id == id));
    } catch (e,st) {
      log.e('❌ id:${id}のPlantがMasterDataに存在しません。$e\n$st');
      return null;
    }
  }

  @override
  PlantMasterEntity? findByIdAndVariant(int id, Variant variant) {
    try {
      return _cache.firstWhere((p) => p.id == id && p.variant == variant);
    } catch (_) {
      log.e('❌ id:${id},variant:${variant}のPlantがMasterDataに存在しません。');
      return null;
    }
  }

  // --- private helper ---
  PlantMasterEntity _fromJson(Map<String, dynamic> e) {
    return PlantMasterEntity(
      id: e['id'] ?? 0,
      name: e['name'] ?? '',
      description: e['description'] ?? '',
      rarity: e['rarity'] ?? 0,
      variant: _parseVariant(e['variant']),
      attribute: _parseAttribute(e['attribute']),
      imageRes: e['imageRes'] ?? '',
    );
  }

  static Variant _parseVariant(String? value) {
    if (value == null) return Variant.none;
    return Variant.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Variant.none,
    );
  }

  static Attribute _parseAttribute(String? value) {
    if (value == null) return Attribute.none;
    return Attribute.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Attribute.none,
    );
  }
}