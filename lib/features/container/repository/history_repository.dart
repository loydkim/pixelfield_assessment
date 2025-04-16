import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/container/models/history.dart';

class HistoryRepository {
  final Box<History> historyBox;

  HistoryRepository(this.historyBox);

  /// Fetches history data from a JSON asset file,
  /// converts it into a list of History objects, and stores (or refreshes)
  /// them in the Hive box.
  Future<List<History>> fetchHistories() async {
    // Load the JSON content from the asset file.
    final String jsonString = await rootBundle.loadString('jsons/history.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    // Convert the JSON list into a list of History objects.
    final List<History> histories =
        jsonList
            .map(
              (jsonItem) => History.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();

    // Save or update each History object in the Hive box.
    // Using the 'label' field as a unique key (make sure it is unique).
    for (final history in histories) {
      await historyBox.put(history.label, history);
    }

    return histories;
  }

  /// Loads and returns all stored History objects from the local Hive box.
  List<History> loadLocalHistories() {
    return historyBox.values.toList();
  }
}
