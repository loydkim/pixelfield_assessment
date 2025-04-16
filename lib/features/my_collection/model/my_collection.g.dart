// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyCollectionAdapter extends TypeAdapter<MyCollection> {
  @override
  final int typeId = 0;

  @override
  MyCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyCollection(
      title: fields[0] as String,
      imagePath: fields[1] as String,
      year: fields[2] as int,
      number: fields[3] as int,
      currentCount: fields[4] as int,
      totalCount: fields[5] as int,
      type: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyCollection obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.currentCount)
      ..writeByte(5)
      ..write(obj.totalCount)
      ..writeByte(6)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
