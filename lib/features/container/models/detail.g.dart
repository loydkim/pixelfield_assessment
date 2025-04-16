// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailAdapter extends TypeAdapter<Detail> {
  @override
  final int typeId = 1;

  @override
  Detail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Detail(
      distillery: fields[0] as String,
      region: fields[1] as String,
      country: fields[2] as String,
      type: fields[3] as String,
      ageStatement: fields[4] as String,
      filled: fields[5] as int,
      bottled: fields[6] as int,
      caskNumber: fields[7] as double,
      abv: fields[8] as double,
      size: fields[9] as String,
      finish: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Detail obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.distillery)
      ..writeByte(1)
      ..write(obj.region)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.ageStatement)
      ..writeByte(5)
      ..write(obj.filled)
      ..writeByte(6)
      ..write(obj.bottled)
      ..writeByte(7)
      ..write(obj.caskNumber)
      ..writeByte(8)
      ..write(obj.abv)
      ..writeByte(9)
      ..write(obj.size)
      ..writeByte(10)
      ..write(obj.finish);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
