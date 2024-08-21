import 'package:dentist_app/app.store.dart';
import 'package:dentist_app/datasources/api/dio/dio_config.dart';
import 'package:dentist_app/datasources/interfaces/product.service.dart';
import 'package:dentist_app/datasources/interfaces/recent_search.service.dart';
import 'package:dentist_app/datasources/mock/product.api.dart';
import 'package:dentist_app/datasources/mock/recent_search.api.dart';
import 'package:dentist_app/datasources/repositories/product.repository.dart';
import 'package:dentist_app/datasources/repositories/recent_search.repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// final getIt = GetIt.instance;
class ServiceLocator {
  void setup() {
    final getIt = GetIt.instance;
    // Register Dio
    getIt.registerSingleton<Dio>(DioConfig().createDio());
    getIt.registerSingleton<AppStore>(AppStore());

    // Register Services
    // getIt.registerLazySingleton<IRecentSearchService>(
    //     () => DioRecentSearchService(getIt<Dio>()));
    // getIt.registerLazySingleton<IProductService>(
    //     () => DioProductService(getIt<Dio>()));
    getIt.registerLazySingleton<IRecentSearchService>(
        () => MockRecentSearchService());
    getIt.registerLazySingleton<IProductService>(() => MockProductService());

    // Register Repositories
    getIt.registerLazySingleton<RecentSearchRepository>(
        () => RecentSearchRepository(getIt<IRecentSearchService>()));
    getIt.registerLazySingleton<ProductRepository>(
        () => ProductRepository(getIt<IProductService>()));
  }
}
