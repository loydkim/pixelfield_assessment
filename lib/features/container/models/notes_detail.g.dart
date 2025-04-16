// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotesDetailAdapter extends TypeAdapter<NotesDetail> {
  @override
  final int typeId = 2;

  @override
  NotesDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesDetail(
      by: fields[0] as String?,
      nose: (fields[1] as List).cast<String>(),
      palate: (fields[2] as List).cast<String>(),
      finish: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotesDetail obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.by)
      ..writeByte(1)
      ..write(obj.nose)
      ..writeByte(2)
      ..write(obj.palate)
      ..writeByte(3)
      ..write(obj.finish);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
