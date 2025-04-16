import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/features/container/bloc/detail_bloc.dart';
import 'package:pixelfield_project/features/container/models/detail.dart';
import 'package:pixelfield_project/features/container/widgets/detail_list_item.dart';

/// Fallback classes for mocktail.
class FakeDetailEvent extends Fake implements DetailEvent {}

class FakeDetailState extends Fake implements DetailState {}

/// A mock DetailBloc using bloc_test.
class MockDetailBloc extends MockBloc<DetailEvent, DetailState>
    implements DetailBloc {}

/// A helper widget that mimics the UI built by your DetailPage’s BlocBuilder.
/// Instead of relying on Hive or creating its own bloc, this widget simply
/// builds the UI based on the provided DetailBloc state.
class TestDetailView extends StatelessWidget {
  const TestDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        switch (state.status) {
          case DetailStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case DetailStatus.success:
            // Show loading if detail is not yet available.
            if (state.detail == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailListItem(
                    label: 'Distillery',
                    value: state.detail!.distillery,
                  ),
                  DetailListItem(label: 'Region', value: state.detail!.region),
                  DetailListItem(
                    label: 'Country',
                    value: state.detail!.country,
                  ),
                  DetailListItem(label: 'Type', value: state.detail!.type),
                  DetailListItem(
                    label: 'Age statement',
                    value: state.detail!.ageStatement,
                  ),
                  DetailListItem(
                    label: 'Filled',
                    value: state.detail!.filled.toString(),
                  ),
                  DetailListItem(
                    label: 'Bottled',
                    value: state.detail!.bottled.toString(),
                  ),
                  DetailListItem(
                    label: 'Cask number',
                    value: state.detail!.caskNumber.toString(),
                  ),
                  DetailListItem(
                    label: 'ABV',
                    value: state.detail!.abv.toString(),
                  ),
                  DetailListItem(label: 'Size', value: state.detail!.size),
                  DetailListItem(label: 'Finish', value: state.detail!.finish),
                ],
              ),
            );
          case DetailStatus.failure:
            return const Center(child: Text('failed to fetch detail'));
        }
      },
    );
  }
}

void main() {
  setUpAll(() {
    // Register fallback values for events and states to avoid errors with mocktail.
    registerFallbackValue(FakeDetailEvent());
    registerFallbackValue(FakeDetailState());
  });

  late MockDetailBloc mockDetailBloc;

  setUp(() {
    mockDetailBloc = MockDetailBloc();
  });

  group('TestDetailView Widget Test with bloc_test', () {
    testWidgets('displays CircularProgressIndicator when state is initial', (
      WidgetTester tester,
    ) async {
      // Arrange: Stub the bloc to return an initial state.
      when(() => mockDetailBloc.state).thenReturn(DetailInitial());

      // Act: Build the widget tree with the mocked bloc injected.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<DetailBloc>.value(
            value: mockDetailBloc,
            child: const TestDetailView(),
          ),
        ),
      );

      // Assert: Verify the loading indicator is shown.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays detail information when state is success', (
      WidgetTester tester,
    ) async {
      // Arrange: Create a dummy Detail instance.
      final dummyDetail = Detail(
        distillery: 'Glenlivet',
        region: 'Speyside',
        country: 'Scotland',
        type: 'Single Malt',
        ageStatement: '12',
        filled: 100,
        bottled: 80,
        caskNumber: 1.0,
        abv: 40.0,
        size: '700ml',
        finish: 'Smooth',
      );

      // Stub the bloc to return a success state containing dummyDetail.
      when(() => mockDetailBloc.state).thenReturn(
        DetailState(status: DetailStatus.success, detail: dummyDetail),
      );

      // Act: Build the widget.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<DetailBloc>.value(
            value: mockDetailBloc,
            child: const TestDetailView(),
          ),
        ),
      );
      // Wait for animations and asynchronous updates.
      await tester.pumpAndSettle();

      // Assert: Verify that the dummy detail's information is displayed.
      expect(find.text('Glenlivet'), findsOneWidget);
      expect(find.text('Speyside'), findsOneWidget);
      expect(find.text('Scotland'), findsOneWidget);
      expect(find.text('Single Malt'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('700ml'), findsOneWidget);
      expect(find.text('Smooth'), findsOneWidget);
      // Also, verify that the label "Distillery" appears.
      expect(find.text('Distillery'), findsOneWidget);
    });

    testWidgets('displays error message when state is failure', (
      WidgetTester tester,
    ) async {
      // Arrange: Stub the bloc to simulate a failure state.
      when(
        () => mockDetailBloc.state,
      ).thenReturn(DetailState(status: DetailStatus.failure, detail: null));

      // Act: Build the widget with the mocked bloc.
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<DetailBloc>.value(
            value: mockDetailBloc,
            child: const TestDetailView(),
          ),
        ),
      );

      // Assert: Verify the error message is shown.
      expect(find.text('failed to fetch detail'), findsOneWidget);
    });
  });
}
