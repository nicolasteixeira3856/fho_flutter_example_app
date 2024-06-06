import 'dart:convert';

import 'package:exam_app/core/network/http_client.dart';
import 'package:exam_app/features/exam/data/datasources/exam_remote_datasource.dart';
import 'package:exam_app/features/exam/data/models/request/number_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late ExamRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ExamRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  group('ExamRemoteDataSource', () {
    const tQuantity = 5;
    final tNumbers = [1, 2, 3, 4, 5];
    final tNumberListModel = NumberListModel(numbers: tNumbers);
    final tNumberListResponse = HttpResponse(200, jsonEncode(tNumbers), {});

    test('should return NumberListModel when the call to API is successful', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => tNumberListResponse);

      // Act
      final result = await dataSource.getRandomNumbers(tQuantity);

      // Assert
      expect(result, tNumberListModel);
      verify(() => mockHttpClient.get('/random-numbers/$tQuantity')).called(1);
    });

    final tCheckOrderResponse = HttpResponse(200, jsonEncode({'isInOrder': true}), {});

    test('should return true when the numbers are in order', () async {
      // Arrange
      when(() => mockHttpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => tCheckOrderResponse);

      // Act
      final result = await dataSource.checkOrder(tNumbers);

      // Assert
      expect(result, true);
      verify(() => mockHttpClient.post('/check-order', data: {'numbers': tNumbers})).called(1);
    });

    test('should throw an exception when the call to API is unsuccessful for getRandomNumbers', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => HttpResponse(500, 'Internal Server Error', {}));

      // Act
      final call = dataSource.getRandomNumbers(tQuantity);

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockHttpClient.get('/random-numbers/$tQuantity')).called(1);
    });

    test('should throw an exception when the call to API is unsuccessful for checkOrder', () async {
      // Arrange
      when(() => mockHttpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => HttpResponse(500, 'Internal Server Error', {}));

      // Act
      final call = dataSource.checkOrder(tNumbers);

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockHttpClient.post('/check-order', data: {'numbers': tNumbers})).called(1);
    });
  });
}
