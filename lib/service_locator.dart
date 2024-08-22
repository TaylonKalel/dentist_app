import 'package:dentist_app/app.store.dart';
import 'package:dentist_app/datasources/api/dio/dio_config.dart';
import 'package:dentist_app/datasources/interfaces/category.service.dart';
import 'package:dentist_app/datasources/interfaces/product.service.dart';
import 'package:dentist_app/datasources/interfaces/recent_search.service.dart';
import 'package:dentist_app/datasources/mock/category.api.dart';
import 'package:dentist_app/datasources/mock/product.api.dart';
import 'package:dentist_app/datasources/mock/recent_search.api.dart';
import 'package:dentist_app/datasources/repositories/category.repository.dart';
import 'package:dentist_app/datasources/repositories/product.repository.dart';
import 'package:dentist_app/datasources/repositories/recent_search.repository.dart';
import 'package:dentist_app/loading.store.dart';
import 'package:dentist_app/pages/home/category/category.store.dart';
import 'package:dentist_app/pages/home/home.store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// final getIt = GetIt.instance;
class ServiceLocator {
  void setup() {
    final getIt = GetIt.instance;
    // Register Stores
    getIt.registerSingleton<Dio>(DioConfig().createDio());
    getIt.registerSingleton<AppStore>(AppStore());
    getIt.registerFactory<LoadingStore>(() => LoadingStore());
    getIt.registerLazySingleton<HomeStore>(() => HomeStore());
    getIt.registerLazySingleton<CategoryStore>(() => CategoryStore());

    // Register Services
    getIt.registerLazySingleton<IRecentSearchService>(
        () => MockRecentSearchService());
    getIt.registerLazySingleton<IProductService>(() => MockProductService());
    getIt.registerLazySingleton<ICategoryService>(() => MockCategoryService());

    // Register Repositories
    getIt.registerLazySingleton<CategoryRepository>(
        () => CategoryRepository(getIt<ICategoryService>()));
    getIt.registerLazySingleton<RecentSearchRepository>(
        () => RecentSearchRepository(getIt<IRecentSearchService>()));
    getIt.registerLazySingleton<ProductRepository>(
        () => ProductRepository(getIt<IProductService>()));
  }
}
