part of 'tasting_notes_bloc.dart';

enum TastingNotesStatus { initial, success, failure }

class TastingNotesState extends Equatable {
  const TastingNotesState({
    this.status = TastingNotesStatus.initial,
    this.tastingNotes,
  });
  final TastingNotesStatus status;
  final TastingNotes? tastingNotes;

  TastingNotesState copyWith({
    TastingNotesStatus? status,
    TastingNotes? tastingNotes,
  }) {
    return TastingNotesState(
      status: status ?? this.status,
      tastingNotes: tastingNotes ?? this.tastingNotes,
    );
  }

  @override
  String toString() {
    return '''TastingNotesState { status: $status, details: $tastingNotes }''';
  }

  @override
  List<Object> get props => [status];
}

final class TastingNotesInitial extends TastingNotesState {}
