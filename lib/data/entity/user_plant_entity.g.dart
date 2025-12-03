// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_plant_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPlantEntityAdapter extends TypeAdapter<UserPlantEntity> {
  @override
  final int typeId = 11;

  @override
  UserPlantEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPlantEntity(
      id: fields[0] as String?,
      plantId: fields[1] as int,
      variant: fields[2] as Variant,
      progress: fields[3] as double,
      growthBoost: fields[4] as int,
      lastWatered: fields[5] as int,
      lastUpdate: fields[6] as int,
      plantCondition: fields[7] as PlantCondition,
      slotIndex: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserPlantEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.plantId)
      ..writeByte(2)
      ..write(obj.variant)
      ..writeByte(3)
      ..write(obj.progress)
      ..writeByte(4)
      ..write(obj.growthBoost)
      ..writeByte(5)
      ..write(obj.lastWatered)
      ..writeByte(6)
      ..write(obj.lastUpdate)
      ..writeByte(7)
      ..write(obj.plantCondition)
      ..writeByte(8)
      ..write(obj.slotIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPlantEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
