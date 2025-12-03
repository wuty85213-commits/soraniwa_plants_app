import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';

///--------------------------------------
/// 🧺 IInventoryRepository（抽象層）
///--------------------------------------
/// 各層からインベントリを安全に操作するための契約クラス。
/// - Realm 実装 / Fake 実装の両方で共通利用。
/// - StoreRepository, UserPlantRepository, ViewModel などで依存注入。
abstract class IInventoryRepository {
  List<Inventory> getAll();
  Inventory? findItem(int itemId, Variant? variant, Attribute? attribute);
  List<Inventory> getSeedItems();
  List<Inventory> getFertilizerItems();
  Future<void> save(Inventory inventory);
  Future<void> clearAll();
}