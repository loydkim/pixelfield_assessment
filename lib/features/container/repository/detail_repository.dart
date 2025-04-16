import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:pixelfield_project/features/container/models/detail.dart';

class DetailRepository {
  final Box<Detail> detailBox;

  DetailRepository(this.detailBox);

  /// Fetches detail data from a JSON asset, converts it to a list of [Detail]
  /// objects, and saves (or refreshes) them in the Hive box.
  Future<List<Detail>> fetchDetails() async {
    // Load the JSON file from assets.
    final String jsonString = await rootBundle.loadString('jsons/detail.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    // Convert each JSON map to a Detail instance.
    final List<Detail> details =
        jsonList
            .map(
              (jsonItem) => Detail.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();

    // Save or update each Detail object in the Hive box.
    // Here, we assume that the 'distillery' field is unique for each detail.
    for (var detail in details) {
      await detailBox.put(detail.distillery, detail);
    }

    return details;
  }

  /// Loads all [Detail] objects stored in the local Hive box.
  List<Detail> loadLocalDetails() {
    return detailBox.values.toList();
  }
}
