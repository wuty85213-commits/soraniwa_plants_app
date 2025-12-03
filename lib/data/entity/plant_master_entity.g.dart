// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_master_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantMasterEntityAdapter extends TypeAdapter<PlantMasterEntity> {
  @override
  final int typeId = 15;

  @override
  PlantMasterEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantMasterEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      rarity: fields[3] as int,
      variant: fields[4] as Variant,
      attribute: fields[5] as Attribute,
      imageRes: (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlantMasterEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.rarity)
      ..writeByte(4)
      ..write(obj.variant)
      ..writeByte(5)
      ..write(obj.attribute)
      ..writeByte(6)
      ..write(obj.imageRes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantMasterEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
