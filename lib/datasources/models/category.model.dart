import 'package:dentist_app/datasources/models/abstract/from_json.abstratct.dart';

class CategoryModel implements FromJsonModel {
  int? categoryId;
  String? name;
  String? description;

  CategoryModel({this.categoryId, this.name, this.description});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) => CategoryModel.fromJson(json);
}
