import 'package:dentist_app/datasources/interfaces/product.service.dart';
import 'package:dentist_app/datasources/models/base.model.dart';
import 'package:dentist_app/datasources/models/product.model.dart';

class ProductRepository {
  final IProductService _productService;

  ProductRepository(this._productService);

  Future<BaseModel<ProductModel>> getProducts() async {
    try {
      final data = await _productService.get();
      return BaseModel<ProductModel>.fromJson(data, tipo: ProductModel());
    } on Exception {
      throw Exception('Failed to load products');
    }
  }
}
