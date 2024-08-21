// import 'package:dentist_app/api/clients/api_client.dart';
// import 'package:dentist_app/api/clients/dio/dio_client.dart';
// import 'package:dentist_app/api/clients/dio/dio_config.dart';
// import 'package:dentist_app/models/base.model.dart';
// import 'package:dentist_app/models/recent_search.api.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dio/dio.dart';
// import 'package:mockito/annotations.dart';

// // class MockDio extends Mock implements Dio {}
// import 'dio_client_test.mocks.dart';

// @GenerateMocks([ApiClient])
// void main() {
//   group('DioClient', () {
//     late MockApiClient mockApiClient;
//     late DioClient dioClient;

//     setUp(() {
//       mockApiClient = MockApiClient();
//       dioClient = DioClient(DioConfig().createDio());
//     });

//     test('should return data when the get request is successful', () async {
//       when(mockApiClient.get('any')).thenAnswer(
//         (_) async =>  Response(
//         data: {'id': 1, 'name': 'John Doe'},
//         statusCode: 200,
//         requestOptions: RequestOptions(path: '/user/1'))),
//       );

//       final result = await dioClient.get('/path');

//       expect(result.status, true);
//       expect(result.item, ["Teste", "Teste 2"]);
//     });

//     // test('should throw an exception when the get request fails', () async {
//     //   when(mockApiClient.get('any')).thenThrow(DioException(
//     //     requestOptions: RequestOptions(path: ''),
//     //   ));

//     //   expect(() => dioClient.get('/path'), throwsException);
//     // });
//   });
// }
