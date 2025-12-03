// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 10;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity(
      id: fields[0] as String?,
      userKey: fields[1] as String,
      coins: fields[2] as int,
      unlockedSlots: fields[3] as int,
      actionFlags: (fields[4] as List?)?.cast<String>(),
      rewardFlags: (fields[5] as List?)?.cast<String>(),
      isBgmOn: fields[6] == null ? true : fields[6] as bool,
      isSeOn: fields[7] == null ? true : fields[7] as bool,
      languageCade: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userKey)
      ..writeByte(2)
      ..write(obj.coins)
      ..writeByte(3)
      ..write(obj.unlockedSlots)
      ..writeByte(4)
      ..write(obj.actionFlags)
      ..writeByte(5)
      ..write(obj.rewardFlags)
      ..writeByte(6)
      ..write(obj.isBgmOn)
      ..writeByte(7)
      ..write(obj.isSeOn)
      ..writeByte(8)
      ..write(obj.languageCade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
