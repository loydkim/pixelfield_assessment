import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';
import 'package:pixelfield_project/features/my_collection/repository/my_collection_repository.dart';

/// A fake implementation of a Hive box that only implements the minimal members
/// required for testing purposes.
class FakeBox<T> implements Box<T> {
  final Map<dynamic, T> _store = {};

  @override
  Future<void> put(dynamic key, T value) async {
    _store[key] = value;
  }

  @override
  Iterable<T> get values => _store.values;

  @override
  T? get(dynamic key, {T? defaultValue}) => _store[key] ?? defaultValue;

  // All other members throw [UnimplementedError] when called.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  // Initialize Flutter binding to enable asset bundle mocking.
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBox<MyCollection> fakeBox;
  late MyCollectionRepository repository;

  // Define test JSON content that contains all required fields.
  const String testJsonContent = '''
  [
    {
      "title": "Test Collection 1",
      "imagePath": "assets/images/collection1.png",
      "year": 2020,
      "number": 1,
      "currentCount": 10,
      "totalCount": 100,
      "type": "Type A"
    },
    {
      "title": "Test Collection 2",
      "imagePath": "assets/images/collection2.png",
      "year": 2021,
      "number": 2,
      "currentCount": 20,
      "totalCount": 200,
      "type": "Type B"
    }
  ]
  ''';

  // Create ByteData from the test JSON string.
  final ByteData testByteData = ByteData.view(
    utf8.encode(testJsonContent).buffer,
  );

  setUp(() {
    // Initialize a fresh fake Hive box and repository before each test.
    fakeBox = FakeBox<MyCollection>();
    repository = MyCollectionRepository(fakeBox);

    // Set up a mock handler to simulate asset loading.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          final String key = utf8.decode(message!.buffer.asUint8List());
          if (key == 'jsons/collection.json') {
            return testByteData;
          }
          return null;
        });
  });

  tearDown(() {
    // Clear the mock handler after each test.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
  });

  group('MyCollectionRepository Tests', () {
    test(
      'fetchCollections loads JSON data, creates MyCollection objects, and saves them to the Hive box',
      () async {
        // Act: Invoke the repository method.
        final List<MyCollection> collections =
            await repository.fetchCollections();

        // Assert: Verify that the parsed list has the expected length.
        expect(collections, isA<List<MyCollection>>());
        expect(collections.length, equals(2));

        // Verify properties for the first collection.
        final item1 = collections.firstWhere((c) => c.number == 1);
        expect(item1.title, equals('Test Collection 1'));
        expect(item1.imagePath, equals('assets/images/collection1.png'));
        expect(item1.year, equals(2020));
        expect(item1.currentCount, equals(10));
        expect(item1.totalCount, equals(100));
        expect(item1.type, equals('Type A'));

        // Verify properties for the second collection.
        final item2 = collections.firstWhere((c) => c.number == 2);
        expect(item2.title, equals('Test Collection 2'));
        expect(item2.imagePath, equals('assets/images/collection2.png'));
        expect(item2.year, equals(2021));
        expect(item2.currentCount, equals(20));
        expect(item2.totalCount, equals(200));
        expect(item2.type, equals('Type B'));

        // Assert: Verify that the FakeBox holds both collections using their "number" as key.
        final storedItem1 = fakeBox.get(1);
        expect(storedItem1, isNotNull);
        expect(storedItem1?.title, equals('Test Collection 1'));

        final storedItem2 = fakeBox.get(2);
        expect(storedItem2, isNotNull);
        expect(storedItem2?.title, equals('Test Collection 2'));
      },
    );

    test(
      'loadLocalCollections returns all stored MyCollection objects',
      () async {
        // Arrange: Pre-populate the fake Hive box with sample MyCollection objects.
        final collection1 = MyCollection(
          title: 'Test Collection 1',
          imagePath: 'assets/images/collection1.png',
          year: 2020,
          number: 1,
          currentCount: 10,
          totalCount: 100,
          type: 'Type A',
        );
        final collection2 = MyCollection(
          title: 'Test Collection 2',
          imagePath: 'assets/images/collection2.png',
          year: 2021,
          number: 2,
          currentCount: 20,
          totalCount: 200,
          type: 'Type B',
        );

        await fakeBox.put(collection1.number, collection1);
        await fakeBox.put(collection2.number, collection2);

        // Act: Retrieve the collections from the repository.
        final List<MyCollection> localCollections =
            repository.loadLocalCollections();

        // Assert: Check that the retrieved collections match the stored ones.
        expect(localCollections.length, equals(2));
        expect(localCollections, containsAll([collection1, collection2]));
      },
    );
  });
}
