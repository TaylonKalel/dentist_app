import 'package:dentist_app/datasources/interfaces/category.service.dart';
import 'package:dentist_app/datasources/models/base.model.dart';
import 'package:dentist_app/datasources/models/category.model.dart';

class CategoryRepository {
  final ICategoryService _productService;

  CategoryRepository(this._productService);

  Future<BaseModel<CategoryModel>> getCategorys() async {
    try {
      final data = await _productService.get();
      return BaseModel<CategoryModel>.fromJson(data, tipo: CategoryModel());
    } on Exception {
      throw Exception('Failed to load products');
    }
  }
}
