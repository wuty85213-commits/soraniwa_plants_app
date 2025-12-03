import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';

part 'item_master_entity.g.dart';

@HiveType(typeId: 14)
class ItemMasterEntity extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  ItemType itemType;

  @HiveField(4)
  int price;

  @HiveField(5)
  Variant? variant;

  @HiveField(6)
  Attribute? attribute;

  @HiveField(7)
  String imageRes;

  ItemMasterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.itemType,
    required this.price,
    this.variant,
    this.attribute,
    required this.imageRes,
  });


  // --- JSON → Entity ---
  factory ItemMasterEntity.fromJson(Map<String, dynamic> json) {
    return ItemMasterEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      itemType: _parseItemType(json['itemType']),
      price: json['price'] ?? 0,
      variant: _parseVariant(json['variant']),
      attribute: _parseAttribute(json['attribute']),
      imageRes: json['imageRes'] ?? '',
    );
  }

  // --- Entity → JSON ---
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'itemType': itemType.name,
    'price': price,
    'variant': variant?.name,
    'attribute': attribute?.name,
    'imageRes': imageRes,
  };

  // --- Enum変換ヘルパ ---
  static ItemType _parseItemType(String? value) {
    if (value == null) return ItemType.seed;
    return ItemType.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ItemType.seed,
    );
  }

  static Variant? _parseVariant(String? value) {
    if (value == null) return Variant.none;
    return Variant.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Variant.none,
    );
  }

  static Attribute? _parseAttribute(String? value) {
    if (value == null) return Attribute.none;
    return Attribute.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Attribute.none,
    );
  }
}
extension ItemSellingExtension on ItemMasterEntity {
  /// 売値を計算するゲッター
  int get sellPrice {
    double basePrice = price.toDouble();

    if (itemType == ItemType.seed) {
      basePrice = 5;
    } else {
      basePrice *= 0.5;
    }
    // 切り捨てして返す
    return basePrice.floor();
  }

  /// デバッグやログ用に便利な説明文を追加してもOk
  String get priceLabel => "💰 売値: ${sellPrice}G";
}
