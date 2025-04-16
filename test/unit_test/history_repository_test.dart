import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/container/models/attachment.dart';
import 'package:pixelfield_project/features/container/models/history.dart';
import 'package:pixelfield_project/features/container/repository/history_repository.dart';

/// A minimal in-memory fake implementation of a Hive [Box] for testing purposes.
class FakeBox<T> implements Box<T> {
  final Map<dynamic, T> _store = {};

  @override
  Future<void> put(dynamic key, T value) async {
    _store[key] = value;
  }

  @override
  T? get(dynamic key, {T? defaultValue}) => _store[key] ?? defaultValue;

  @override
  Iterable<T> get values => _store.values;

  // Other members are not required for these tests.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  // Ensure Flutter binding is initialized for asset bundle mocking.
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBox<History> fakeBox;
  late HistoryRepository repository;

  // Define a JSON string representing a list of History objects.
  // Each history contains a label, title, descriptions, and a list of attachments.
  const String testJsonContent = '''
  [
    {
      "label": "history1",
      "title": "History One",
      "descriptions": ["description1", "description2"],
      "attachments": [
        {
          "attachmentName": "file1.pdf",
          "attachmentUrl": "http://example.com/file1.pdf"
        },
        {
          "attachmentName": "file2.pdf",
          "attachmentUrl": "http://example.com/file2.pdf"
        }
      ]
    },
    {
      "label": "history2",
      "title": "History Two",
      "descriptions": ["description3"],
      "attachments": [
        {
          "attachmentName": "file3.pdf",
          "attachmentUrl": "http://example.com/file3.pdf"
        }
      ]
    }
  ]
  ''';

  // Convert the JSON string to ByteData for asset mocking.
  final ByteData testByteData = ByteData.view(
    utf8.encode(testJsonContent).buffer,
  );

  setUp(() {
    // Initialize a fresh FakeBox and HistoryRepository before each test.
    fakeBox = FakeBox<History>();
    repository = HistoryRepository(fakeBox);

    // Set up a mock message handler so that loading "jsons/history.json"
    // returns our predefined JSON as ByteData.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          final String key = utf8.decode(message!.buffer.asUint8List());
          if (key == 'jsons/history.json') {
            return testByteData;
          }
          return null;
        });
  });

  tearDown(() {
    // Remove the asset handler mock after each test.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
  });

  group('HistoryRepository Tests', () {
    test(
      'fetchHistories loads JSON, converts to History objects, and stores them in the Hive box',
      () async {
        // Act: Invoke the fetchHistories method.
        final List<History> histories = await repository.fetchHistories();

        // Assert: Verify that two History objects are returned.
        expect(histories, isA<List<History>>());
        expect(histories.length, equals(2));

        // Validate the first History object's fields.
        final History history1 = histories.firstWhere(
          (history) => history.label == 'history1',
        );
        expect(history1.title, equals('History One'));
        expect(history1.descriptions, equals(['description1', 'description2']));
        expect(history1.attachments.length, equals(2));
        expect(history1.attachments[0].attachmentName, equals('file1.pdf'));
        expect(
          history1.attachments[0].attachmentUrl,
          equals('http://example.com/file1.pdf'),
        );
        expect(history1.attachments[1].attachmentName, equals('file2.pdf'));
        expect(
          history1.attachments[1].attachmentUrl,
          equals('http://example.com/file2.pdf'),
        );

        // Validate the second History object's fields.
        final History history2 = histories.firstWhere(
          (history) => history.label == 'history2',
        );
        expect(history2.title, equals('History Two'));
        expect(history2.descriptions, equals(['description3']));
        expect(history2.attachments.length, equals(1));
        expect(history2.attachments[0].attachmentName, equals('file3.pdf'));
        expect(
          history2.attachments[0].attachmentUrl,
          equals('http://example.com/file3.pdf'),
        );

        // Verify that each History object was stored in the fake Hive box using its label as the key.
        final History? storedHistory1 = fakeBox.get('history1');
        final History? storedHistory2 = fakeBox.get('history2');
        expect(storedHistory1, isNotNull);
        expect(storedHistory1, equals(history1));
        expect(storedHistory2, isNotNull);
        expect(storedHistory2, equals(history2));
      },
    );

    test('loadLocalHistories returns all stored History objects', () {
      // Arrange: Pre-populate the FakeBox with two History objects.
      final History history1 = History(
        label: 'history1',
        title: 'History One',
        descriptions: ['description1', 'description2'],
        attachments: [
          Attachment(
            attachmentName: 'file1.pdf',
            attachmentUrl: 'http://example.com/file1.pdf',
          ),
          Attachment(
            attachmentName: 'file2.pdf',
            attachmentUrl: 'http://example.com/file2.pdf',
          ),
        ],
      );
      final History history2 = History(
        label: 'history2',
        title: 'History Two',
        descriptions: ['description3'],
        attachments: [
          Attachment(
            attachmentName: 'file3.pdf',
            attachmentUrl: 'http://example.com/file3.pdf',
          ),
        ],
      );
      fakeBox.put(history1.label, history1);
      fakeBox.put(history2.label, history2);

      // Act: Retrieve the stored histories.
      final List<History> localHistories = repository.loadLocalHistories();

      // Assert: Verify that both History objects are returned.
      expect(localHistories.length, equals(2));
      expect(localHistories, containsAll([history1, history2]));
    });
  });
}
