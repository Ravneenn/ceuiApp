// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersAdapter extends TypeAdapter<Users> {
  @override
  final int typeId = 2;

  @override
  Users read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Users(
      usUserName: fields[0] as String,
      usPassword: fields[1] as String,
      usName: fields[2] as String,
      usLastName: fields[3] as String,
      compID: fields[4] as String,
      isAdmin: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Users obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.usUserName)
      ..writeByte(1)
      ..write(obj.usPassword)
      ..writeByte(2)
      ..write(obj.usName)
      ..writeByte(3)
      ..write(obj.usLastName)
      ..writeByte(4)
      ..write(obj.compID)
      ..writeByte(5)
      ..write(obj.isAdmin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
