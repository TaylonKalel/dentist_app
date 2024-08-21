import 'package:dentist_app/datasources/interfaces/recent_search.service.dart';
import 'package:dentist_app/datasources/models/base.model.dart';
import 'package:dentist_app/datasources/models/recent_search.model.dart';

class RecentSearchRepository {
  final IRecentSearchService _productService;

  RecentSearchRepository(this._productService);

  Future<BaseModel<RecentSearchModel>> getRecentSearchs() async {
    try {
      final data = await _productService.get();
      return BaseModel<RecentSearchModel>.fromJson(data,
          tipo: RecentSearchModel());
    } catch (e) {
      throw Exception(e);
    }
  }
}
