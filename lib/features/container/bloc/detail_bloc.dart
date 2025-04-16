import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/features/container/models/detail.dart';
import 'package:pixelfield_project/features/container/repository/detail_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({required DetailRepository detailRepository})
    : _detailRepository = detailRepository,
      super(DetailInitial()) {
    on<DetailFetched>(_onFetched);
  }
  final DetailRepository _detailRepository;

  Future<void> _onFetched(
    DetailFetched event,
    Emitter<DetailState> emit,
  ) async {
    try {
      final localDetails = _detailRepository.loadLocalDetails();

      if (localDetails.isNotEmpty) {
        emit(
          state.copyWith(
            status: DetailStatus.success,
            detail: localDetails.first,
          ),
        );
      } else {
        final fetchedCollections = await _detailRepository.fetchDetails();

        emit(
          state.copyWith(
            status: DetailStatus.success,
            detail: fetchedCollections.first,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: DetailStatus.failure));
    }
    return;
  }
}
