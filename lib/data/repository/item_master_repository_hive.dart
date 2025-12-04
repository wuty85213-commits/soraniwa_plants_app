import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/domain/repository/i_item_master_repository.dart';

class ItemMasterRepositoryHive implements IItemMasterRepository {
  final log = AppLogger.tag('ItemMasterRepo📜');
  final Box<ItemMasterEntity> _box;
  bool _loaded = false;
  List<ItemMasterEntity> _cache = [];

  ItemMasterRepositoryHive(this._box);

  @override
  Future<void> loadAll({String localeCode = 'ja'}) async {
    if (_loaded) {
      log.w('⚠️ マスタデータはロード済みです');
      return;
    }

    // 既存データがある場合はキャッシュ利用
    if (_box.isNotEmpty) {
      _cache = _box.values.toList();
      _loaded = true;
      log.i('ℹ️ 既存Hiveデータを利用しました');
      return;
    }
    // ✅ Hiveが空なら assets JSON からロード
    log.d('🌱 Loading Plant Master from JSON...');

    // --- JSONから初期ロード ---
    try {
      final path = 'assets/items_$localeCode.json';
      final jsonString = await rootBundle.loadString(path);
      final data = json.decode(jsonString) as List<dynamic>;

      final items = data
          .map((e) => ItemMasterEntity.fromJson(e as Map<String, dynamic>))
          .toList();

      for (final item in items) {
        await _box.put(item.id, item);
      }

      _cache = items;
      _loaded = true;
      log.i('✅ JSONからロード完了 (${items.length}件)');
    } catch (e, st) {
      log.e('❌ JSONロード中にエラー → $e\n$st');
      rethrow;
    }
  }

  @override
  List<ItemMasterEntity> getAll() => _cache;

  @override
  ItemMasterEntity? findById(int id) {
    try {
      return _cache.firstWhere((i) => i.id == id);
    } catch (e,st) {
      log.e('❌ id:${id}のPlantがMasterDataに存在しません。$e\n$st');
      return null;
    }
  }

  @override
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

  // --- private helper ---
  ItemMasterEntity _fromJson(Map<String, dynamic> e) {
    return ItemMasterEntity(
      id: e['id'] ?? 0,
      name: e['name'] ?? '',
      description: e['description'] ?? '',
      itemType: _parseItemType(e['itemType']),
      price: e['price'] ?? 0,
      variant: _parseVariant(e['variant']),
      attribute: _parseAttribute(e['attribute']),
      imageRes: e['imageRes'] ?? '',
    );
  }

  static ItemType _parseItemType(String? value) {
    if (value == null) return ItemType.seed;
    return ItemType.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ItemType.seed,
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