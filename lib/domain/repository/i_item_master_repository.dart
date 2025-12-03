import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';

/// アイテムマスターの抽象リポジトリ
abstract class IItemMasterRepository {
  /// 初回ロード（JSON → Realm or キャッシュ）
  Future<void> loadAll({String localeCode = 'ja'});

  /// 全アイテム取得
  List<ItemMasterEntity> getAll();

  /// ID指定取得
  ItemMasterEntity? findById(int id);

  /// デバッグ・開発用：JSONから再読み込み
  Future<void> reloadFromJson({String localeCode = 'ja'});
}