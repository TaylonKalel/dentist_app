import 'package:dentist_app/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfig {
  Dio createDio() {
    final dio = Dio();
    dio.options.baseUrl = baseApiUrl;
    dio.options.connectTimeout = const Duration(seconds: 5); // 5s
    dio.options.receiveTimeout = const Duration(seconds: 3000); // 3s
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger()); // Add logger
    }

    return dio;
  }
}
