import 'package:dentist_app/datasources/interfaces/recent_search.service.dart';
import 'package:dio/dio.dart';

class DioRecentSearchService implements IRecentSearchService {
  final Dio _dio;

  DioRecentSearchService(this._dio);

  @override
  Future<Map<String, dynamic>> get() async {
    final response = await _dio.get('recent_search');
    return response.data;
  }
}
