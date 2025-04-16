import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/features/container/bloc/tasting_notes_bloc.dart';
import 'package:pixelfield_project/features/container/models/tasting_notes.dart';
import 'package:pixelfield_project/features/container/models/notes_detail.dart';
import 'package:pixelfield_project/features/container/widgets/tasting_notes_list_item.dart';

/// Fallback classes for mocktail.
class FakeTastingNotesEvent extends Fake implements TastingNotesEvent {}

class FakeTastingNotesState extends Fake implements TastingNotesState {}

/// A mock TastingNotesBloc using bloc_test.
class MockTastingNotesBloc
    extends MockBloc<TastingNotesEvent, TastingNotesState>
    implements TastingNotesBloc {}

/// A test helper widget that reproduces the BlocBuilder portion of your TastingNotesPage.
class TestTastingNotesView extends StatelessWidget {
  const TestTastingNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TastingNotesBloc, TastingNotesState>(
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
                    // Top placeholder (e.g. video or image)
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.black,
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Display two tasting notes items.
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
    );
  }
}

void main() {
  // Register fallback values to avoid errors when using mocktail.
  setUpAll(() {
    registerFallbackValue(FakeTastingNotesEvent());
    registerFallbackValue(FakeTastingNotesState());
  });

  late MockTastingNotesBloc mockTastingNotesBloc;

  setUp(() {
    mockTastingNotesBloc = MockTastingNotesBloc();
  });

  group('TestTastingNotesView Widget Test with bloc_test', () {
    testWidgets('displays CircularProgressIndicator when state is initial', (
      WidgetTester tester,
    ) async {
      // Arrange: Stub the bloc state as initial.
      when(() => mockTastingNotesBloc.state).thenReturn(TastingNotesInitial());

      // Act: Pump the widget with our mocked bloc.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TastingNotesBloc>.value(
            value: mockTastingNotesBloc,
            child: const TestTastingNotesView(),
          ),
        ),
      );

      // Assert: Verify that a CircularProgressIndicator is displayed.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays tasting notes when state is success', (
      WidgetTester tester,
    ) async {
      // Arrange: Create a dummy TastingNotes instance.
      final dummyTastingNotes = TastingNotes(
        tastingNotes: NotesDetail(
          by: 'Expert',
          nose: ['floral', 'smoky'],
          palate: ['sweet'],
          finish: ['long'],
        ),
        yourNotes: NotesDetail(
          by: 'User',
          nose: ['citrus'],
          palate: ['bitter'],
          finish: ['short'],
        ),
      );

      // Stub the bloc state as success with the dummy tasting notes.
      when(() => mockTastingNotesBloc.state).thenReturn(
        TastingNotesState(
          status: TastingNotesStatus.success,
          tastingNotes: dummyTastingNotes,
        ),
      );

      // Act: Pump the widget.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TastingNotesBloc>.value(
            value: mockTastingNotesBloc,
            child: const TestTastingNotesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TastingNotesListItem), findsNWidgets(2));
    });

    testWidgets('displays error message when state is failure', (
      WidgetTester tester,
    ) async {
      // Arrange: Stub the bloc state as failure.
      when(() => mockTastingNotesBloc.state).thenReturn(
        TastingNotesState(
          status: TastingNotesStatus.failure,
          tastingNotes: null,
        ),
      );

      // Act: Pump the widget.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TastingNotesBloc>.value(
            value: mockTastingNotesBloc,
            child: const TestTastingNotesView(),
          ),
        ),
      );

      // Assert: Verify that the error message is displayed.
      expect(find.text('failed to fetch my tasting notes'), findsOneWidget);
    });
  });
}
