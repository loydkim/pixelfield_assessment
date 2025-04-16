part of 'history_bloc.dart';

enum HistoryStatus { initial, success, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.histories = const <History>[],
  });

  final HistoryStatus status;
  final List<History> histories;

  HistoryState copyWith({HistoryStatus? status, List<History>? histories}) {
    return HistoryState(
      status: status ?? this.status,
      histories: histories ?? this.histories,
    );
  }

  @override
  String toString() {
    return '''HistoryState { status: $status, histories: $histories }''';
  }

  @override
  List<Object> get props => [status, histories];
}

final class HistoryInitial extends HistoryState {}
