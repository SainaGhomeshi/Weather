import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

List<String> cities;

Future<String> loadJsonData() async {
  var jsonText = await rootBundle.loadString('assets/cities.json');
  cities = json.decode(jsonText);
  return 'success';
}


class SearchInCities {
  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}