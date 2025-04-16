// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasting_notes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TastingNotesAdapter extends TypeAdapter<TastingNotes> {
  @override
  final int typeId = 3;

  @override
  TastingNotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TastingNotes(
      tastingNotes: fields[0] as NotesDetail,
      yourNotes: fields[1] as NotesDetail,
    );
  }

  @override
  void write(BinaryWriter writer, TastingNotes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tastingNotes)
      ..writeByte(1)
      ..write(obj.yourNotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TastingNotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
