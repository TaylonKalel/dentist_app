import 'dart:convert';

import 'package:dentist_app/datasources/interfaces/recent_search.service.dart';
import 'package:flutter/services.dart';

class MockRecentSearchService implements IRecentSearchService {
  @override
  Future<Map<String, dynamic>> get() async {
    var json = jsonDecode(
        await rootBundle.loadString('assets/json/recent_search.json'));
    return json;
  }
}
