import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:exam_api/api/exam_api_impl.dart';
import 'package:exam_api/services/random_number_service.dart';
import 'package:exam_api/services/order_check_service.dart';
import 'dart:convert';

void main() async {
  final randomNumberService = RandomNumberService();
  final orderCheckService = OrderCheckService();
  final examApi = ExamApiImpl(randomNumberService, orderCheckService);

  final router = Router();

  router.get('/random-numbers/<quantity|[0-9]+>',
      (Request request, String quantity) {
    final qty = int.parse(quantity);
    final numbers = examApi.getRandomNumbers(qty);
    final jsonResponse = jsonEncode(numbers);
    return Response.ok(jsonResponse,
        headers: {'Content-Type': 'application/json'});
  });

  router.post('/check-order', (Request request) async {
    final payload = await request.readAsString();
    final Map<String, dynamic> jsonMap = jsonDecode(payload);
    final List<int> numbers =
        (jsonMap['numbers'] as List<dynamic>).map((e) => e as int).toList();
    final isInOrder = examApi.checkOrder(numbers);
    final jsonResponse = jsonEncode({'isInOrder': isInOrder});
    return Response.ok(jsonResponse,
        headers: {'Content-Type': 'application/json'});
  });

  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Servidor rodando em http://${server.address.host}:${server.port}');
}
