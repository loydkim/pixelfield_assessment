import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/container/models/detail.dart';
import 'package:pixelfield_project/features/container/repository/detail_repository.dart';

/// A simple in-memory fake implementation of a Hive [Box] for testing.
class FakeBox<T> implements Box<T> {
  final Map<dynamic, T> _store = {};

  @override
  Future<void> put(dynamic key, T value) async {
    _store[key] = value;
  }

  @override
  Iterable<T> get values => _store.values;

  @override
  T? get(key, {T? defaultValue}) => _store[key] ?? defaultValue;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  // Ensure Flutter bindings are initialized for asset bundle mocks.
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBox<Detail> fakeBox;
  late DetailRepository repository;

  // Define a test JSON string matching the [Detail] model fields.
  const String testJsonContent = '''
  [
    {
      "distillery": "Glenfiddich",
      "region": "Speyside",
      "country": "Scotland",
      "type": "Single Malt",
      "ageStatement": "12",
      "filled": 100,
      "bottled": 80,
      "caskNumber": 1.0,
      "abv": 40.0,
      "size": "700ml",
      "finish": "Long"
    },
    {
      "distillery": "Lagavulin",
      "region": "Islay",
      "country": "Scotland",
      "type": "Single Malt",
      "ageStatement": "16",
      "filled": 50,
      "bottled": 45,
      "caskNumber": 2.0,
      "abv": 43.0,
      "size": "700ml",
      "finish": "Peaty"
    }
  ]
  ''';

  // Create ByteData from the test JSON string for asset mocking.
  final ByteData testByteData = ByteData.view(
    utf8.encode(testJsonContent).buffer,
  );

  setUp(() {
    // Initialize a fresh FakeBox and DetailRepository before each test.
    fakeBox = FakeBox<Detail>();
    repository = DetailRepository(fakeBox);

    // Set up a mock handler to simulate loading the 'jsons/detail.json' asset.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          final String key = utf8.decode(message!.buffer.asUint8List());
          if (key == 'jsons/detail.json') {
            return testByteData;
          }
          return null;
        });
  });

  tearDown(() {
    // Clear the mock after each test.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
  });

  group('DetailRepository Tests', () {
    test(
      'fetchDetails loads JSON, converts to Detail objects, and saves them in the Hive box',
      () async {
        // Act: Call fetchDetails to load and store details.
        final List<Detail> details = await repository.fetchDetails();

        // Assert: Verify that two Detail objects were created.
        expect(details, isA<List<Detail>>());
        expect(details.length, equals(2));

        // Validate the first Detail object's fields.
        final Detail detail1 = details.firstWhere(
          (d) => d.distillery == 'Glenfiddich',
        );
        expect(detail1.region, equals('Speyside'));
        expect(detail1.country, equals('Scotland'));
        expect(detail1.type, equals('Single Malt'));
        expect(detail1.ageStatement, equals('12'));
        expect(detail1.filled, equals(100));
        expect(detail1.bottled, equals(80));
        expect(detail1.caskNumber, equals(1.0));
        expect(detail1.abv, equals(40.0));
        expect(detail1.size, equals('700ml'));
        expect(detail1.finish, equals('Long'));

        // Validate the second Detail object's fields.
        final Detail detail2 = details.firstWhere(
          (d) => d.distillery == 'Lagavulin',
        );
        expect(detail2.region, equals('Islay'));
        expect(detail2.country, equals('Scotland'));
        expect(detail2.type, equals('Single Malt'));
        expect(detail2.ageStatement, equals('16'));
        expect(detail2.filled, equals(50));
        expect(detail2.bottled, equals(45));
        expect(detail2.caskNumber, equals(2.0));
        expect(detail2.abv, equals(43.0));
        expect(detail2.size, equals('700ml'));
        expect(detail2.finish, equals('Peaty'));

        // Verify that the details were stored in FakeBox using distillery names as keys.
        expect(fakeBox.get('Glenfiddich')?.distillery, equals('Glenfiddich'));
        expect(fakeBox.get('Lagavulin')?.distillery, equals('Lagavulin'));
      },
    );

    test('loadLocalDetails returns all stored Detail objects', () async {
      // Arrange: Prepopulate the fake box with Detail objects.
      final detail1 = Detail(
        distillery: 'Glenfiddich',
        region: 'Speyside',
        country: 'Scotland',
        type: 'Single Malt',
        ageStatement: '12',
        filled: 100,
        bottled: 80,
        caskNumber: 1.0,
        abv: 40.0,
        size: '700ml',
        finish: 'Long',
      );
      final detail2 = Detail(
        distillery: 'Lagavulin',
        region: 'Islay',
        country: 'Scotland',
        type: 'Single Malt',
        ageStatement: '16',
        filled: 50,
        bottled: 45,
        caskNumber: 2.0,
        abv: 43.0,
        size: '700ml',
        finish: 'Peaty',
      );
      await fakeBox.put(detail1.distillery, detail1);
      await fakeBox.put(detail2.distillery, detail2);

      // Act: Retrieve local details from the repository.
      final List<Detail> localDetails = repository.loadLocalDetails();

      // Assert: Ensure that both details are retrieved.
      expect(localDetails.length, equals(2));
      expect(localDetails, containsAll([detail1, detail2]));
    });
  });
}
