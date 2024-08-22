import 'package:dentist_app/datasources/models/category.model.dart';
import 'package:dentist_app/datasources/repositories/category.repository.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'category.store.g.dart';

// ignore: library_private_types_in_public_api
class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  late final CategoryRepository _categoryService;
  _CategoryStore() {
    _categoryService = GetIt.instance<CategoryRepository>();
  }

  @observable
  List<CategoryModel> categories = [];

  @action
  Future getCategories() async {
    if (categories.isNotEmpty) return;
    var list = await _categoryService.getCategorys();
    if (list.list != null) {
      categories.addAll(list.list!);
    }
  }
}
