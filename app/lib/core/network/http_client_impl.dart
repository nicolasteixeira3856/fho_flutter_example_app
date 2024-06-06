import 'dart:convert';
import 'package:exam_app/core/network/http_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl implements HttpClient {
  final http.Client client;

  HttpClientImpl({required this.client});

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    headers = {...?headers, 'Content-Type': 'application/json'};
    final response =
        await client.get(Uri.parse('${dotenv.env['API_URL']}$url'));
    return _processResponse(response);
  }

  @override
  Future<HttpResponse> post(String url,
      {Map<String, String>? headers, Map<String, dynamic>? data}) async {
    final response = await client.post(
      Uri.parse('${dotenv.env['API_URL']}$url'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  HttpResponse _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;
    final headers = response.headers;
    return HttpResponse(statusCode, body, headers);
  }
}
