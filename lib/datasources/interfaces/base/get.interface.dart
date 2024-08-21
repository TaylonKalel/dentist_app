import 'package:dentist_app/datasources/models/abstract/from_json.abstratct.dart';

abstract mixin class IGet<T extends FromJsonModel> {
  Future<Map<String, dynamic>> get();
}
