// import 'package:dentist_app/api/dio/dio_client.dart';
// import 'package:dentist_app/api/dio/dio_config.dart';
// import 'package:dentist_app/models/base.model.dart';
// import 'package:dentist_app/models/recent_search.model.dart';
// import 'package:dentist_app/repositories/recent_search.repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';

// // class MockDio extends Mock implements Dio {}
// import 'recent_search_test.mocks.dart';

// @GenerateMocks([RecentSearchRepository])
// void main() {
//   group('DioClient', () {
//     late MockRecentSearchRepository mockApiClient;
//     late RecentSearchRepository dioClient;

//     setUp(() {
//       mockApiClient = MockRecentSearchRepository();
//       dioClient = RecentSearchRepository(MockRecentSearchRepository());
//     });

//     test('should return data when the get request is successful', () async {
//       when(mockApiClient.getResearch()).thenAnswer((_) async =>
//           BaseModel<RecentSearchModel>(
//               item: RecentSearchModel(list: ['Teste', 'teste1']),
//               status: true));
//       final result = await dioClient.getResearch();
//       expect(result.status, true);
//       // expect(result.item, ["Teste", "Teste 2"]);
//     });
//   });
// }
