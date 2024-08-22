import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:dentist_app/datasources/repositories/product.repository.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'home.store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ProductRepository _productService = GetIt.instance();

  ObservableList<ProductModel> producs = ObservableList();

  @action
  Future getProducts() async {
    var r = await _productService.getProducts();
    producs.addAll(r.list!);
  }
}
