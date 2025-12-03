import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/datasource/collected_local_datasource.dart';
import 'package:myplantapp_ver1/domain/mappers.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';
import 'package:myplantapp_ver1/domain/repository/i_collected_repository.dart';

/// Hive上で動作する Collected（収穫済み植物）リポジトリ
class CollectedRepository implements ICollectedRepository {
  final CollectedLocalDataSource _local;


  CollectedRepository(this._local);
  final log = AppLogger.tag("CollectedRepo📁");

  /// 全データ取得
  @override
  List<Collected> getAll() {
    return _local.getAll().map((e) => e.toDomain()).toList();
  }

  Collected? find(int plantId, Variant variant) {
    final collected = getAll();
    return collected.firstWhereOrNull(
            (e) => e.plantId == plantId && e.variant == variant);
  }

  @override
  Future<void> save(Collected collected) async {
    final entity = collected.toEntity();
    await _local.put(entity);
  }

  /// 植物を削除（コレクションから）
  @override
  Future<void> remove(int plantId, Variant variant) async {
    final existing = find(plantId, variant);
    if (existing == null) return;

    await existing.toEntity().delete();
    log.i('🗑️ ${variant.name}(${plantId}) を削除しました');
  }

  /// 全削除
  @override
  Future<void> clearAll() async {
    await _local.clear();
    log.w('⚠️ 全収穫データを削除しました');
  }

  @override
  Stream<List<Collected>> watchAll() =>
      _local.watchAll().map((list) => list.map((e) => e.toDomain()).toList());
}