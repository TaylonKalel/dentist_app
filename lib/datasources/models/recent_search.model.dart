import 'package:dentist_app/datasources/models/abstract/from_json.abstratct.dart';

class RecentSearchModel implements FromJsonModel {
  late List<String> list;

  RecentSearchModel({List<String>? list}) {
    this.list = list ?? [];
  }

  RecentSearchModel.fromJson(Map<String, dynamic> json) {
    list = json['item'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = list;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) => RecentSearchModel.fromJson(json);
}
