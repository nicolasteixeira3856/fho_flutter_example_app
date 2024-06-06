import 'dart:convert';

import 'package:exam_app/core/network/http_client_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

Future<void> main() async {
  late HttpClientImpl httpClientImpl;
  late MockHttpClient mockHttpClient;
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  setUp(() {
    mockHttpClient = MockHttpClient();
    httpClientImpl = HttpClientImpl(client: mockHttpClient);
  });

  setUpAll(() {
    // Registering Uri fallback value
    registerFallbackValue(Uri());
  });

  group('HttpClientImpl', () {
    const tUrl = '/test-url';
    const apiUrl = 'http://10.0.2.2:8080'; // Adapte ao seu ambiente de teste
    final fullUrl = Uri.parse('$apiUrl$tUrl');
    const tHeaders = {'Content-Type': 'application/json'};
    const tBody = {'key': 'value'};
    final tResponse = http.Response(jsonEncode(tBody), 200);

    test('should perform a GET request and return HttpResponse', () async {
      // Arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => tResponse);

      // Act
      final result = await httpClientImpl.get(tUrl);

      // Assert
      expect(result.statusCode, 200);
      expect(result.body, jsonEncode(tBody));
      verify(() => mockHttpClient.get(
        fullUrl,
        headers: any(named: 'headers'),
      )).called(1);
    });

    test('should perform a POST request and return HttpResponse', () async {
      // Arrange
      when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => tResponse);

      // Act
      final result = await httpClientImpl.post(tUrl, data: tBody);

      // Assert
      expect(result.statusCode, 200);
      expect(result.body, jsonEncode(tBody));
      verify(() => mockHttpClient.post(
        fullUrl,
        headers: tHeaders,
        body: jsonEncode(tBody),
      )).called(1);
    });

    test('should throw an exception if GET request fails', () async {
      // Arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(Exception('Failed to load'));

      // Act
      final call = httpClientImpl.get(tUrl);

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockHttpClient.get(
        fullUrl,
        headers: any(named: 'headers'),
      )).called(1);
    });

    test('should throw an exception if POST request fails', () async {
      // Arrange
      when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenThrow(Exception('Failed to load'));

      // Act
      final call = httpClientImpl.post(tUrl, data: tBody);

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockHttpClient.post(
        fullUrl,
        headers: tHeaders,
        body: jsonEncode(tBody),
      )).called(1);
    });
  });
}
