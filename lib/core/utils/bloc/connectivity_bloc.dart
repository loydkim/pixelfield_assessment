import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ConnectivityBloc({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity(),
      super(ConnectivityInitial()) {
    // Register event handler for connectivity changes.
    on<ConnectivityChanged>((event, emit) {
      if (event.connectivityResult == ConnectivityResult.none) {
        emit(ConnectivityOffline());
      } else {
        emit(ConnectivityOnline());
      }
    });

    // Listen for connectivity changes using connectivity_plus.
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .expand((results) => results) // Flatten the list of results
        .listen((result) {
          add(ConnectivityChanged(result));
        });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
