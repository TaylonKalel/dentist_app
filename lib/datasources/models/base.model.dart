import 'package:dentist_app/datasources/models/abstract/from_json.abstratct.dart';
import 'package:flutter/foundation.dart';

class BaseModel<T extends FromJsonModel> {
  late bool status;
  String? message;
  T? item;
  List<T>? list;

  BaseModel({this.status = false, this.message, this.item, this.list});

  BaseModel.fromJson(Map<String, dynamic> json, {T? tipo}) {
    try {
      status = json['status'];
      message = json['message'];
      if (tipo != null && json['item'] != null) {
        if (json['item'] is List) {
          item = tipo.fromJson({"item": json['item'] as List<dynamic>});
        } else {
          item = tipo.fromJson(json['item']);
        }
      }
      if (tipo != null && json['list'] != null) {
        var l = json['list'] as List<dynamic>;
        list = <T>[];
        for (var element in l) {
          if (element != null) {
            list!.add(tipo.fromJson(element));
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['item'] = item;
    data['list'] = list;
    return data;
  }
}
