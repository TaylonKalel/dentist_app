import 'package:dentist_app/datasources/models/abstract/from_json.abstratct.dart';

class ProductModel extends FromJsonModel {
  String? title;
  String? description;
  double? price;
  double? newPrice;
  int? maxInstallments;
  int? discount;
  double? monthlyValue;
  DateTime? dateAdded;
  bool? isNew;
  String? image;
  String? category;

  ProductModel(
      {this.title,
      this.description,
      this.price,
      this.maxInstallments,
      this.dateAdded,
      this.monthlyValue,
      this.isNew,
      this.image,
      this.category});

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    price = json['price'];
    newPrice = price;
    maxInstallments = json['max_installments'];
    dateAdded = DateTime.tryParse(json['date_added']);
    isNew = json['is_new'];
    category = json['category'];
    discount = json['discount'];
    image = json['image'];
    if (discount != null) {
      newPrice = price! * ((100 - discount!) / 100);
    }
    if (newPrice != null && maxInstallments != null) {
      monthlyValue = newPrice! / maxInstallments!;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['max_installments'] = maxInstallments;
    data['date_added'] = dateAdded.toString();
    data['is_new'] = isNew;
    data['category'] = category;
    data['image'] = image;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) => ProductModel.fromJson(json);
}
