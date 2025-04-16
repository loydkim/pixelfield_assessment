import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';
import 'package:pixelfield_project/features/my_collection/repository/my_collection_repository.dart';

part 'my_collection_event.dart';
part 'my_collection_state.dart';

class MyCollectionBloc extends Bloc<MyCollectionEvent, MyCollectionState> {
  MyCollectionBloc({required MyCollectionRepository myCollectionRepository})
    : _myCollectionRepository = myCollectionRepository,
      super(MyCollectionInitial()) {
    on<MyCollectionFetched>(_onFetched);
  }

  final MyCollectionRepository _myCollectionRepository;

  Future<void> _onFetched(
    MyCollectionFetched event,
    Emitter<MyCollectionState> emit,
  ) async {
    try {
      final localCollections = _myCollectionRepository.loadLocalCollections();

      if (localCollections.isNotEmpty) {
        emit(
          state.copyWith(
            status: MyCollectionStatus.success,
            myCollections: [...state.myCollections, ...localCollections],
          ),
        );
      } else {
        final fetchedCollections =
            await _myCollectionRepository.fetchCollections();

        emit(
          state.copyWith(
            status: MyCollectionStatus.success,
            myCollections: [...state.myCollections, ...fetchedCollections],
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: MyCollectionStatus.failure));
    }
    return;
  }
}
