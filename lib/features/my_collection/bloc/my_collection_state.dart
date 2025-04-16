part of 'my_collection_bloc.dart';

enum MyCollectionStatus { initial, success, failure }

class MyCollectionState extends Equatable {
  const MyCollectionState({
    this.status = MyCollectionStatus.initial,
    this.myCollections = const <MyCollection>[],
  });

  final MyCollectionStatus status;
  final List<MyCollection> myCollections;

  MyCollectionState copyWith({
    MyCollectionStatus? status,
    List<MyCollection>? myCollections,
  }) {
    return MyCollectionState(
      status: status ?? this.status,
      myCollections: myCollections ?? this.myCollections,
    );
  }

  @override
  String toString() {
    return '''MyCollectionState { status: $status, myCollections: ${myCollections.length} }''';
  }

  @override
  List<Object> get props => [status, myCollections];
}

final class MyCollectionInitial extends MyCollectionState {}
