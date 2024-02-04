// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reports.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportsAdapter extends TypeAdapter<Reports> {
  @override
  final int typeId = 4;

  @override
  Reports read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reports(
      reportName: fields[0] as String,
      writtenby: fields[1] as String,
      reciever: fields[2] as String,
      report: fields[3] as String,
      date: fields[4] as String,
      task: fields[5] as String,
      compId: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Reports obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.reportName)
      ..writeByte(1)
      ..write(obj.writtenby)
      ..writeByte(2)
      ..write(obj.reciever)
      ..writeByte(3)
      ..write(obj.report)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.task)
      ..writeByte(6)
      ..write(obj.compId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
