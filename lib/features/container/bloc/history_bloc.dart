import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixelfield_project/features/container/models/history.dart';
import 'package:pixelfield_project/features/container/repository/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required HistoryRepository historyRepository})
    : _historyRepository = historyRepository,
      super(HistoryInitial()) {
    on<HistoryFetched>(_onFetched);
  }

  final HistoryRepository _historyRepository;

  Future<void> _onFetched(
    HistoryFetched event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      final localTastingNotes = _historyRepository.loadLocalHistories();

      if (localTastingNotes.isNotEmpty) {
        emit(
          state.copyWith(
            status: HistoryStatus.success,
            histories: localTastingNotes,
          ),
        );
      } else {
        final fetchedTastingNotes = await _historyRepository.fetchHistories();

        emit(
          state.copyWith(
            status: HistoryStatus.success,
            histories: fetchedTastingNotes,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: HistoryStatus.failure));
    }
    return;
  }
}
