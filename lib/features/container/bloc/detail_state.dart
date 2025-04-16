part of 'detail_bloc.dart';

enum DetailStatus { initial, success, failure }

class DetailState extends Equatable {
  const DetailState({this.status = DetailStatus.initial, this.detail});

  final DetailStatus status;
  final Detail? detail;

  DetailState copyWith({DetailStatus? status, Detail? detail}) {
    return DetailState(
      status: status ?? this.status,
      detail: detail ?? this.detail,
    );
  }

  @override
  String toString() {
    return '''DetailState { status: $status, details: $detail }''';
  }

  @override
  List<Object> get props => [status];
}

final class DetailInitial extends DetailState {}
