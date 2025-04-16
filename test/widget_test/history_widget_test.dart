import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/features/container/bloc/history_bloc.dart';
import 'package:pixelfield_project/features/container/models/history.dart';
import 'package:pixelfield_project/features/container/models/attachment.dart';
import 'package:pixelfield_project/features/container/widgets/history_list_item.dart';

/// Fallback classes needed by mocktail.
class FakeHistoryEvent extends Fake implements HistoryEvent {}

class FakeHistoryState extends Fake implements HistoryState {}

/// A mock HistoryBloc using bloc_test.
class MockHistoryBloc extends MockBloc<HistoryEvent, HistoryState>
    implements HistoryBloc {}

/// A helper widget that reproduces the UI built by HistoryPage’s BlocBuilder,
/// without involving Hive or the repository. It uses the HistoryBloc's state
/// to decide what to render.
class TestHistoryView extends StatelessWidget {
  const TestHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
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
    );
  }
}

void main() {
  // Register fallback values to avoid errors when using mocktail.
  setUpAll(() {
    registerFallbackValue(FakeHistoryEvent());
    registerFallbackValue(FakeHistoryState());
  });

  late MockHistoryBloc mockHistoryBloc;

  setUp(() {
    mockHistoryBloc = MockHistoryBloc();
  });

  group('TestHistoryView Widget Test with bloc_test', () {
    testWidgets('displays CircularProgressIndicator when state is initial', (
      WidgetTester tester,
    ) async {
      // Arrange: Stub the bloc to return the initial state.
      when(() => mockHistoryBloc.state).thenReturn(HistoryInitial());

      // Act: Pump the widget with our mocked bloc.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HistoryBloc>.value(
            value: mockHistoryBloc,
            child: const TestHistoryView(),
          ),
        ),
      );

      // Assert: Verify that a CircularProgressIndicator is displayed.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays history items when state is success', (
      WidgetTester tester,
    ) async {
      // Arrange: Create dummy History instances.
      final dummyHistory1 = History(
        label: 'history1',
        title: 'History One',
        descriptions: ['desc1', 'desc2'],
        attachments: [
          Attachment(
            attachmentName: 'file1.pdf',
            attachmentUrl: 'http://example.com/file1.pdf',
          ),
          Attachment(
            attachmentName: 'file1.pdf',
            attachmentUrl: 'http://example.com/file1.pdf',
          ),
          Attachment(
            attachmentName: 'file1.pdf',
            attachmentUrl: 'http://example.com/file1.pdf',
          ),
        ],
      );
      final dummyHistory2 = History(
        label: 'history2',
        title: 'History Two',
        descriptions: ['desc3', 'desc4'],
        attachments: [
          Attachment(
            attachmentName: 'file2.pdf',
            attachmentUrl: 'http://example.com/file2.pdf',
          ),
          Attachment(
            attachmentName: 'file2.pdf',
            attachmentUrl: 'http://example.com/file2.pdf',
          ),
          Attachment(
            attachmentName: 'file2.pdf',
            attachmentUrl: 'http://example.com/file2.pdf',
          ),
        ],
      );

      // Stub the bloc to return a success state with dummy histories.
      when(() => mockHistoryBloc.state).thenReturn(
        HistoryState(
          status: HistoryStatus.success,
          histories: [dummyHistory1, dummyHistory2],
        ),
      );

      // Act: Pump the widget.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HistoryBloc>.value(
            value: mockHistoryBloc,
            child: const TestHistoryView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // // Assert: Verify that HistoryListItem widgets are rendered.
      expect(find.byType(HistoryListItem), findsNWidgets(2));
      // Check for text that should appear from one of the dummy History objects.
      expect(find.text('History One'), findsOneWidget);
      expect(find.text('History Two'), findsOneWidget);
    });

    testWidgets('displays error message when state is failure', (
      WidgetTester tester,
    ) async {
      // Arrange: Stub the bloc to return a failure state.
      when(
        () => mockHistoryBloc.state,
      ).thenReturn(HistoryState(status: HistoryStatus.failure, histories: []));

      // Act: Pump the widget.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HistoryBloc>.value(
            value: mockHistoryBloc,
            child: const TestHistoryView(),
          ),
        ),
      );

      // Assert: Verify that the error message is displayed.
      expect(find.text('failed to fetch my collection'), findsOneWidget);
    });
  });
}
