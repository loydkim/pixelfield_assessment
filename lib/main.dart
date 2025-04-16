import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/app.dart';
import 'package:pixelfield_project/core/utils/db_init.dart';
import 'package:pixelfield_project/core/utils/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  await DbInit.initHive();
  runApp(const App());
}
