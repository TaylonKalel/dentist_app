import 'package:dentist_app/datasources/interfaces/product.service.dart';
import 'package:dio/dio.dart';

class DioProductService implements IProductService {
  final Dio _dio;

  DioProductService(this._dio);

  @override
  Future<Map<String, dynamic>> get() async {
    final response = await _dio.get('products');
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getBySearch(String key) {
    // TODO: implement getBySearch
    throw UnimplementedError();
  }
}
