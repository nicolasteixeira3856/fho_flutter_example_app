abstract class HttpClient {
  Future<HttpResponse> get(String url, {Map<String, String>? headers});
  Future<HttpResponse> post(String url, {Map<String, String>? headers, Map<String, dynamic>? data});
}

class HttpResponse {
  final int statusCode;
  final String body;
  final Map<String, String> headers;

  HttpResponse(this.statusCode, this.body, this.headers);
}