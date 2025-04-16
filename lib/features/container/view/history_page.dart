import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/core/constatns/db_key.dart';
import 'package:pixelfield_project/features/container/bloc/history_bloc.dart';
import 'package:pixelfield_project/features/container/models/history.dart';
import 'package:pixelfield_project/features/container/repository/history_repository.dart';
import 'package:pixelfield_project/features/container/widgets/history_list_item.dart';

class HistoryPage extends StatelessWidget {
  final String title;
  final Color panelColor;

  const HistoryPage({super.key, required this.title, required this.panelColor});

  @override
  Widget build(BuildContext context) {
    final dataBox = Hive.box<History>(historyKey);
    final historyRepository = HistoryRepository(dataBox);
    return BlocProvider(
      create:
          (_) =>
              HistoryBloc(historyRepository: historyRepository)
                ..add(HistoryFetched()),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          switch (state.status) {
            case HistoryStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case HistoryStatus.success:
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children:
                        state.histories
                            .map((history) => HistoryListItem(history: history))
                            .toList(),
                  ),
                ),
              );
            case HistoryStatus.failure:
              return const Center(child: Text('failed to fetch my collection'));
          }
        },
      ),
    );
  }
}
