import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/features/my_collection/bloc/my_collection_bloc.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';
import 'package:pixelfield_project/features/my_collection/view/my_collection_list.dart';
import 'package:pixelfield_project/features/my_collection/widgets/my_collection_item.dart';

class FakeMyCollectionEvent extends Fake implements MyCollectionEvent {}

class FakeMyCollectionState extends Fake implements MyCollectionState {}

class MockMyCollectionBloc
    extends MockBloc<MyCollectionEvent, MyCollectionState>
    implements MyCollectionBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeMyCollectionEvent());
    registerFallbackValue(FakeMyCollectionState());
  });

  late MockMyCollectionBloc mockBloc;

  setUp(() {
    mockBloc = MockMyCollectionBloc();
  });

  group('MyCollectionList Widget with bloc_test', () {
    testWidgets('displays CircularProgressIndicator when state is initial', (
      WidgetTester tester,
    ) async {
      when(() => mockBloc.state).thenReturn(MyCollectionInitial());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MyCollectionBloc>.value(
            value: mockBloc,
            child: const MyCollectionList(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays GridView with collection items when state is success', (
      WidgetTester tester,
    ) async {
      final dummyCollections = [
        MyCollection(
          title: 'Collection A',
          imagePath: 'assets/item.png',
          year: 2020,
          number: 1,
          currentCount: 10,
          totalCount: 100,
          type: 'Type A',
        ),
        MyCollection(
          title: 'Collection B',
          imagePath: 'assets/item.png',
          year: 2021,
          number: 2,
          currentCount: 20,
          totalCount: 200,
          type: 'Type B',
        ),
      ];

      when(() => mockBloc.state).thenReturn(
        MyCollectionState(
          status: MyCollectionStatus.success,
          myCollections: dummyCollections,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MyCollectionBloc>.value(
            value: mockBloc,
            child: const MyCollectionList(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);

      // Instead of checking for text "Collection A", let's find MyCollectionItem widgets.
      final itemFinder = find.byType(MyCollectionItem);
      expect(itemFinder, findsNWidgets(dummyCollections.length));
    });

    testWidgets('displays error message when state is failure', (
      WidgetTester tester,
    ) async {
      when(() => mockBloc.state).thenReturn(
        MyCollectionState(
          status: MyCollectionStatus.failure,
          myCollections: [],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MyCollectionBloc>.value(
            value: mockBloc,
            child: const MyCollectionList(),
          ),
        ),
      );

      expect(find.text('failed to fetch my collection'), findsOneWidget);
    });
  });
}
