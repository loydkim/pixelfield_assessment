import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/container/models/tasting_notes.dart';

class TastingNotesRepository {
  final Box<TastingNotes> tastingNotesBox;

  TastingNotesRepository(this.tastingNotesBox);

  /// Fetches tasting notes data from a JSON asset file, converts it
  /// into a list of TastingNotes objects, and stores (or refreshes)
  /// them in the Hive box.
  ///
  /// The JSON asset file is expected to be a list of TastingNotes objects.
  /// Adjust the asset path if necessary.

  Future<TastingNotes> fetchTastingNotes() async {
    // Load the JSON content from the asset file.
    final String jsonString = await rootBundle.loadString(
      'jsons/tasting_notes.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Convert the JSON map into a TastingNotes instance.
    final TastingNotes tastingNotes = TastingNotes.fromJson(jsonMap);

    // Save or update the TastingNotes object in the Hive box using a constant key.
    await tastingNotesBox.put('tastingNotes', tastingNotes);

    return tastingNotes;
  }

  /// Loads the stored TastingNotes object from the Hive box.
  /// Returns null if no data exists.
  TastingNotes? loadLocalTastingNotes() {
    return tastingNotesBox.get('tastingNotes');
  }
}
