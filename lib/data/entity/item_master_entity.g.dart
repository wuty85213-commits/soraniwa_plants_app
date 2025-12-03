// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_master_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemMasterEntityAdapter extends TypeAdapter<ItemMasterEntity> {
  @override
  final int typeId = 14;

  @override
  ItemMasterEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemMasterEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      itemType: fields[3] as ItemType,
      price: fields[4] as int,
      variant: fields[5] as Variant?,
      attribute: fields[6] as Attribute?,
      imageRes: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemMasterEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.itemType)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.variant)
      ..writeByte(6)
      ..write(obj.attribute)
      ..writeByte(7)
      ..write(obj.imageRes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemMasterEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
