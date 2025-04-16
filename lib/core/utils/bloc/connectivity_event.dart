part of 'connectivity_bloc.dart';

/// Event for connectivity changes.
abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when connectivity status changes.
class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult connectivityResult;

  const ConnectivityChanged(this.connectivityResult);

  @override
  List<Object?> get props => [connectivityResult];
}
