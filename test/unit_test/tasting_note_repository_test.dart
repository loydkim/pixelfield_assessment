import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/container/models/tasting_notes.dart';
import 'package:pixelfield_project/features/container/models/notes_detail.dart';
import 'package:pixelfield_project/features/container/repository/tasting_notes_repository.dart';

/// A minimal in-memory fake implementation of Hive [Box] for testing.
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
  // Ensure the Flutter binding is initialized for asset bundle mocking.
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBox<TastingNotes> fakeBox;
  late TastingNotesRepository repository;

  // Define a test JSON string for TastingNotes.
  // This JSON object contains nested objects for "tastingNotes" and "yourNotes".
  // The nested JSON is expected to match the structure required by NotesDetail.fromJson.
  const String testJsonContent = '''
  {
    "tastingNotes": {
      "by": "Expert",
      "nose": ["floral", "smoky"],
      "palate": ["spicy", "sweet"],
      "finish": ["smooth", "lingering"]
    },
    "yourNotes": {
      "by": "User",
      "nose": ["citrus"],
      "palate": ["bitter"],
      "finish": ["short"]
    }
  }
  ''';

  // Convert the JSON string to ByteData for asset mocking.
  final ByteData testByteData = ByteData.view(
    utf8.encode(testJsonContent).buffer,
  );

  setUp(() {
    // Initialize a fresh FakeBox and repository instance before each test.
    fakeBox = FakeBox<TastingNotes>();
    repository = TastingNotesRepository(fakeBox);

    // Set up a mock asset handler such that when the asset "jsons/tasting_notes.json" is loaded,
    // it returns our predefined JSON.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          final String key = utf8.decode(message!.buffer.asUint8List());
          if (key == 'jsons/tasting_notes.json') {
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

  group('TastingNotesRepository Tests', () {
    test(
      'fetchTastingNotes loads JSON, parses to TastingNotes, and stores it',
      () async {
        // Act: Fetch the tasting notes via the repository.
        final TastingNotes fetchedNotes = await repository.fetchTastingNotes();

        // Assert: Verify the fields for the "tastingNotes" section.
        expect(fetchedNotes.tastingNotes.by, equals('Expert'));
        expect(fetchedNotes.tastingNotes.nose, equals(['floral', 'smoky']));
        expect(fetchedNotes.tastingNotes.palate, equals(['spicy', 'sweet']));
        expect(
          fetchedNotes.tastingNotes.finish,
          equals(['smooth', 'lingering']),
        );

        // Assert: Verify the fields for the "yourNotes" section.
        expect(fetchedNotes.yourNotes.by, equals('User'));
        expect(fetchedNotes.yourNotes.nose, equals(['citrus']));
        expect(fetchedNotes.yourNotes.palate, equals(['bitter']));
        expect(fetchedNotes.yourNotes.finish, equals(['short']));

        // Verify that the tasting notes were stored in the fake Hive box using the key "tastingNotes".
        final TastingNotes? storedNotes = fakeBox.get('tastingNotes');
        expect(storedNotes, isNotNull);
        expect(storedNotes, equals(fetchedNotes));
      },
    );

    test('loadLocalTastingNotes returns the stored TastingNotes object', () {
      // Arrange: Manually create a TastingNotes instance.
      final TastingNotes localNotes = TastingNotes(
        tastingNotes: NotesDetail(
          by: "LocalExpert",
          nose: ["earthy", "woody"],
          palate: ["rich"],
          finish: ["long"],
        ),
        yourNotes: NotesDetail(
          by: "LocalUser",
          nose: ["fresh"],
          palate: ["light"],
          finish: ["clean"],
        ),
      );

      // Pre-populate the fake box with the TastingNotes object.
      fakeBox.put('tastingNotes', localNotes);

      // Act: Retrieve the tasting notes from the repository.
      final TastingNotes? loadedNotes = repository.loadLocalTastingNotes();

      // Assert: Verify that the loaded notes match the locally stored instance.
      expect(loadedNotes, isNotNull);
      expect(loadedNotes, equals(localNotes));
    });
  });
}
