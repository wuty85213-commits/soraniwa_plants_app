// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collected_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectedEntityAdapter extends TypeAdapter<CollectedEntity> {
  @override
  final int typeId = 13;

  @override
  CollectedEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectedEntity(
      id: fields[0] as String?,
      plantId: fields[1] as int,
      variant: fields[2] as Variant,
      attribute: fields[3] as Attribute,
      harvestCount: fields[4] as int,
      lastHarvestedAt: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CollectedEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.plantId)
      ..writeByte(2)
      ..write(obj.variant)
      ..writeByte(3)
      ..write(obj.attribute)
      ..writeByte(4)
      ..write(obj.harvestCount)
      ..writeByte(5)
      ..write(obj.lastHarvestedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectedEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
