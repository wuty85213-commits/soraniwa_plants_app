// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryEntityAdapter extends TypeAdapter<InventoryEntity> {
  @override
  final int typeId = 12;

  @override
  InventoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryEntity(
      id: fields[0] as String?,
      itemId: fields[1] as int,
      itemType: fields[2] as ItemType,
      variant: fields[3] as Variant?,
      attribute: fields[4] as Attribute?,
      quantity: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemId)
      ..writeByte(2)
      ..write(obj.itemType)
      ..writeByte(3)
      ..write(obj.variant)
      ..writeByte(4)
      ..write(obj.attribute)
      ..writeByte(5)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
