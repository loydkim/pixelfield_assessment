import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/core/constatns/db_key.dart';
import 'package:pixelfield_project/features/container/bloc/tasting_notes_bloc.dart';
import 'package:pixelfield_project/features/container/models/tasting_notes.dart';
import 'package:pixelfield_project/features/container/repository/tasting_notes_repository.dart';
import 'package:pixelfield_project/features/container/widgets/tasting_notes_list_item.dart';

class TastingNotesPage extends StatelessWidget {
  final String title;
  final Color panelColor;

  const TastingNotesPage({
    super.key,
    required this.title,
    required this.panelColor,
  });

  @override
  Widget build(BuildContext context) {
    final dataBox = Hive.box<TastingNotes>(tastingNotesKey);
    final tastingNotesRepository = TastingNotesRepository(dataBox);
    return BlocProvider(
      create:
          (_) =>
              TastingNotesBloc(tastingNotesRepository: tastingNotesRepository)
                ..add(TastingNotesFetched()),
      child: BlocBuilder<TastingNotesBloc, TastingNotesState>(
        builder: (context, state) {
          switch (state.status) {
            case TastingNotesStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case TastingNotesStatus.success:
              if (state.tastingNotes == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top placeholder (video or image)
                      Container(
                        height: 200,
                        width: double.infinity,
                        color:
                            Colors
                                .black, // Black background for the placeholder
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 64,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Your notes header
                      TastingNotesListItem(
                        notesDetail: state.tastingNotes!.tastingNotes,
                      ),
                      TastingNotesListItem(
                        notesDetail: state.tastingNotes!.yourNotes,
                      ),
                    ],
                  ),
                ),
              );
            case TastingNotesStatus.failure:
              return const Center(
                child: Text('failed to fetch my tasting notes'),
              );
          }
        },
      ),
    );
  }
}
