import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixelfield_project/features/container/models/tasting_notes.dart';
import 'package:pixelfield_project/features/container/repository/tasting_notes_repository.dart';

part 'tasting_notes_event.dart';
part 'tasting_notes_state.dart';

class TastingNotesBloc extends Bloc<TastingNotesEvent, TastingNotesState> {
  TastingNotesBloc({required TastingNotesRepository tastingNotesRepository})
    : _tastingNotesRepository = tastingNotesRepository,
      super(TastingNotesInitial()) {
    on<TastingNotesFetched>(_onFetched);
  }
  final TastingNotesRepository _tastingNotesRepository;

  Future<void> _onFetched(
    TastingNotesFetched event,
    Emitter<TastingNotesState> emit,
  ) async {
    try {
      final localTastingNotes = _tastingNotesRepository.loadLocalTastingNotes();

      if (localTastingNotes != null) {
        emit(
          state.copyWith(
            status: TastingNotesStatus.success,
            tastingNotes: localTastingNotes,
          ),
        );
      } else {
        final fetchedTastingNotes =
            await _tastingNotesRepository.fetchTastingNotes();

        emit(
          state.copyWith(
            status: TastingNotesStatus.success,
            tastingNotes: fetchedTastingNotes,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: TastingNotesStatus.failure));
    }
    return;
  }
}
