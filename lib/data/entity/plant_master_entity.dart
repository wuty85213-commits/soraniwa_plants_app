import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';

part 'plant_master_entity.g.dart';

@HiveType(typeId: 15)
class PlantMasterEntity extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  int rarity;

  @HiveField(4)
  Variant variant;

  @HiveField(5)
  Attribute attribute;

  @HiveField(6)
  List<String> imageRes;

  PlantMasterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.rarity,
    required this.variant,
    required this.attribute,
    required this.imageRes,
  });
  // --- JSON → Entity 変換 ---
  factory PlantMasterEntity.fromJson(Map<String, dynamic> json) {
    return PlantMasterEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rarity: json['rarity'] ?? 0,
      variant: _parseVariant(json['variant']),
      attribute: _parseAttribute(json['attribute']),
      imageRes: (json['imageRes']is List)
          ? List<String>.from(json['imageRes'])
          : ((){
            debugPrint("⚠️ imageRes missing or invalid for plant id=${json['id']}");
            return <String>[];
          })(),
    );
  }

  // --- Entity → JSON 変換 ---
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'rarity': rarity,
    'variant': variant.name,
    'attribute': attribute.name,
    'imageRes': imageRes,
  };

  // --- Enum変換ヘルパ ---
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