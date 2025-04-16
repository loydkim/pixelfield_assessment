part of 'history_bloc.dart';

class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

final class HistoryFetched extends HistoryEvent {}
