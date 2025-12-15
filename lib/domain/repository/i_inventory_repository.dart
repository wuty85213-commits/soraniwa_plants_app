import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';

abstract class IInventoryRepository {
  List<Inventory> getAll();
  Inventory? findItem(int itemId, Variant? variant, Attribute? attribute);
  List<Inventory> getSeedItems();
  List<Inventory> getFertilizerItems();
  Future<void> save(Inventory inventory);
  Future<void> clearAll();
}