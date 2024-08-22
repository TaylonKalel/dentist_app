import 'package:dentist_app/datasources/interfaces/base/get.interface.dart';

abstract class IProductService extends IGet {
  Future<Map<String, dynamic>> getBySearch(String key);
}
