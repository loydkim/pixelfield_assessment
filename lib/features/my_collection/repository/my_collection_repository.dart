import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';

class MyCollectionRepository {
  final Box<MyCollection> collectionBox;

  MyCollectionRepository(this.collectionBox);

  /// Fetches data from a JSON asset, converts to a list of MyCollection,
  /// and saves (or refreshes) each entry in the Hive box.
  Future<List<MyCollection>> fetchCollections() async {
    // Load the JSON content from assets.
    final String jsonString = await rootBundle.loadString(
      'jsons/collection.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);

    // Convert JSON map to MyCollection objects.
    final List<MyCollection> collections =
        jsonList
            .map(
              (jsonItem) =>
                  MyCollection.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();

    // Save or update each MyCollection in Hive.
    // In this example, we use the 'number' property as a unique key.
    for (final collection in collections) {
      await collectionBox.put(collection.number, collection);
    }

    return collections;
  }

  /// Loads all MyCollection objects stored in the Hive box.
  List<MyCollection> loadLocalCollections() {
    return collectionBox.values.toList();
  }
}
