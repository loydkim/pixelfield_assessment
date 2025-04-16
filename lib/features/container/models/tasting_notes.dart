import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'notes_detail.dart';

part 'tasting_notes.g.dart';

@HiveType(typeId: 3)
class TastingNotes extends Equatable {
  @HiveField(0)
  final NotesDetail tastingNotes;

  @HiveField(1)
  final NotesDetail yourNotes;

  const TastingNotes({required this.tastingNotes, required this.yourNotes});

  /// Creates an instance of TastingNotes from a JSON map.
  factory TastingNotes.fromJson(Map<String, dynamic> json) {
    return TastingNotes(
      tastingNotes: NotesDetail.fromJson(
        json['tastingNotes'] as Map<String, dynamic>,
      ),
      yourNotes: NotesDetail.fromJson(
        json['yourNotes'] as Map<String, dynamic>,
      ),
    );
  }

  /// Converts an instance of TastingNotes to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'tastingNotes': tastingNotes.toJson(),
      'yourNotes': yourNotes.toJson(),
    };
  }

  @override
  List<Object?> get props => [tastingNotes, yourNotes];
}
