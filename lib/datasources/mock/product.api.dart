import 'dart:convert';

import 'package:dentist_app/datasources/interfaces/product.service.dart';
import 'package:flutter/services.dart';

class MockProductService implements IProductService {
  @override
  Future<Map<String, dynamic>> get() async {
    var json =
        jsonDecode(await rootBundle.loadString('assets/json/products.json'));
    return json;
  }
}
