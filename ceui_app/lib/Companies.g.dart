// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Companies.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompaniesAdapter extends TypeAdapter<Companies> {
  @override
  final int typeId = 1;

  @override
  Companies read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Companies(
      companyName: fields[0] as String,
      companyId: fields[1] as String,
      companyPassword: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Companies obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.companyId)
      ..writeByte(2)
      ..write(obj.companyPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompaniesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
