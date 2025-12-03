import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/collected_entity.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/pot_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_plant_entity.dart';


/// 🌿 Enumを安全に扱う共通アダプタ
class EnumVersionedAdapter<T extends Enum> extends TypeAdapter<T> {
  final int typeId;
  final Map<String, T> mapping;

  EnumVersionedAdapter({
    required this.typeId,
    required this.mapping,
  });

  @override
  T read(BinaryReader reader) {
    final key = reader.readString();
    return mapping[key] ?? mapping.values.first;
  }

  @override
  void write(BinaryWriter writer, T obj) {
    writer.writeString(obj.name);
  }
}

/// 🌱 プロジェクト全体のHiveアダプタ登録を一括で行う関数
Future<void> registerAllHiveAdapters() async {
  // --- Enum登録 ---
  if(!Hive.isAdapterRegistered(1)){
    Hive.registerAdapter(
      EnumVersionedAdapter<Variant>(
        typeId: 1,
        mapping: {
          'NORMAL': Variant.NORMAL,
          'GOLD': Variant.GOLD,
          'RAINBOW': Variant.RAINBOW,
          'none': Variant.none,
        },
      ),
    );
  }

  if(!Hive.isAdapterRegistered(2)){
    Hive.registerAdapter(
      EnumVersionedAdapter<ItemType>(
        typeId: 2,
        mapping: {
          'seed': ItemType.seed,
          'growthBoost': ItemType.growthBoost,
          'rarerateboostRow': ItemType.rarerateboostRow,
          'rarerateboostHigh': ItemType.rarerateboostHigh,
          'rarerateboostSuper': ItemType.rarerateboostSuper,
          'decoration': ItemType.decoration,
        },
      ),
    );
  }

  if(!Hive.isAdapterRegistered(3)){
    Hive.registerAdapter(
      EnumVersionedAdapter<Attribute>(
        typeId: 3,
        mapping: {
          'leafy': Attribute.leafy,
          'bloom': Attribute.bloom,
          'tree': Attribute.tree,
          'fun': Attribute.fun,
          'odd': Attribute.odd,
          'none': Attribute.none,
        },
      ),
    );
  }

  if(!Hive.isAdapterRegistered(4)){
    Hive.registerAdapter(
      EnumVersionedAdapter<PlantCondition>(
        typeId: 4,
        mapping: {
          'wet': PlantCondition.wet,
          'dry': PlantCondition.dry,
          'wither': PlantCondition.wither,
        },
      ),
    );
  }

  // --- Entity登録 ---
  if(!Hive.isAdapterRegistered(10)) {
    Hive.registerAdapter(UserEntityAdapter());
  }
  if(!Hive.isAdapterRegistered(11)) {
    Hive.registerAdapter(UserPlantEntityAdapter());
  }
  if(!Hive.isAdapterRegistered(12)) {
    Hive.registerAdapter(InventoryEntityAdapter());
  }
  if(!Hive.isAdapterRegistered(13)) {
    Hive.registerAdapter(CollectedEntityAdapter());
  }
  if(!Hive.isAdapterRegistered(14)) {
    Hive.registerAdapter(ItemMasterEntityAdapter());
  }
  if(!Hive.isAdapterRegistered(15)) {
    Hive.registerAdapter(PlantMasterEntityAdapter());
  }
  if(!Hive.isAdapterRegistered(16)) {
    Hive.registerAdapter(PotEntityAdapter());
  }
}