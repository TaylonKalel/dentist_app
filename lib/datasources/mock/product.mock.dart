import 'dart:convert';

import 'package:dentist_app/datasources/interfaces/product.service.dart';
import 'package:dentist_app/datasources/models/base.model.dart';
import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:flutter/services.dart';

class MockProductService implements IProductService {
  @override
  Future<Map<String, dynamic>> get() async {
    var json =
        jsonDecode(await rootBundle.loadString('assets/json/products.json'));
    return json;
  }

  @override
  Future<Map<String, dynamic>> getBySearch(String key) async {
    var json =
        jsonDecode(await rootBundle.loadString('assets/json/products.json'));
    var resultBaseModel = BaseModel.fromJson(json, tipo: ProductModel());
    resultBaseModel.list ??= [];
    List<ProductModel> r = [];
    r.addAll(resultBaseModel.list!.where((test) => _test(test, key)));
    resultBaseModel.list!.clear();
    resultBaseModel.list!.addAll(r);
    List<dynamic> teste = [];
    for (var element in resultBaseModel.list!) {
      teste.add(element.toJson());
    }
    return {"status": true, "list": teste};
  }

  bool _test(ProductModel test, String key) {
    key = key.toLowerCase();
    return test.title!.toLowerCase().contains(key) ||
        test.description!.toLowerCase().contains(key) ||
        test.price.toString().contains(key) ||
        test.category!.toLowerCase().contains(key);
  }
}
