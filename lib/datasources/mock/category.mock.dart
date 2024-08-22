import 'dart:convert';
import 'package:dentist_app/datasources/interfaces/category.service.dart';
import 'package:flutter/services.dart';

class MockCategoryService implements ICategoryService {
  @override
  Future<Map<String, dynamic>> get() async {
    var json =
        jsonDecode(await rootBundle.loadString('assets/json/categories.json'));
    return json;
  }
}
