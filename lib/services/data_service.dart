import 'dart:convert'; // for jsonDecode()

import 'package:flutter/services.dart'; // for rootBundle

import '../models/language.dart';

/// Handles loading and parsing the local JSON file.
class DataService {
  /// Reads assets/data/languages.json and returns a list of Language objects.
  static Future<List<Language>> loadLanguages() async {
    // 1. Read the JSON file from the assets folder as plain text
    final String jsonString =
        await rootBundle.loadString('assets/data/languages.json');

    // 2. Convert the text into a Dart List
    final List<dynamic> jsonList = jsonDecode(jsonString);

    // 3. Convert each map in the list into a Language object
    return jsonList.map((item) => Language.fromJson(item)).toList();
  }
}
