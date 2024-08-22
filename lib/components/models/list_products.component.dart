import 'package:dentist_app/datasources/models/product.model.dart';

class ListProductsComponentModel {
  late String title;
  late List<ProductModel> products;

  ListProductsComponentModel({required this.title, required this.products});
}
