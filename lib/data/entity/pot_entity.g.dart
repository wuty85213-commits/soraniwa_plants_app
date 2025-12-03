// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pot_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PotEntityAdapter extends TypeAdapter<PotEntity> {
  @override
  final int typeId = 16;

  @override
  PotEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PotEntity(
      id: fields[0] as String?,
      slotIndex: fields[1] as int,
      itemId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PotEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.slotIndex)
      ..writeByte(2)
      ..write(obj.itemId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PotEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
