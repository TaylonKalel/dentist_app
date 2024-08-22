import 'package:dentist_app/datasources/interfaces/category.service.dart';
import 'package:dio/dio.dart';

class DioCategoryService implements ICategoryService {
  final Dio _dio;

  DioCategoryService(this._dio);

  @override
  Future<Map<String, dynamic>> get() async {
    final response = await _dio.get('category');
    return response.data;
  }
}
