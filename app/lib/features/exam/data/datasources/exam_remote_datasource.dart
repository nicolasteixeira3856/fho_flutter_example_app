import 'dart:convert';

import 'package:exam_app/features/exam/data/models/response/check_order_response_model.dart';

import '../../../../core/network/http_client.dart';
import '../models/request/number_list_model.dart';

abstract class ExamRemoteDataSource {
  Future<NumberListModel> getRandomNumbers(int quantity);

  Future<bool> checkOrder(List<int> numbers);
}

class ExamRemoteDataSourceImpl implements ExamRemoteDataSource {
  final HttpClient httpClient;

  ExamRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<NumberListModel> getRandomNumbers(int quantity) async {
    final response = await httpClient.get('/random-numbers/$quantity');
    _validateResponse(response);
    final jsonResponse = json.decode(response.body);
    return NumberListModel.fromJson({'numbers': List<int>.from(jsonResponse)});
  }

  @override
  Future<bool> checkOrder(List<int> numbers) async {
    final response =
        await httpClient.post('/check-order', data: {"numbers": numbers});
    _validateResponse(response);
    final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
    final checkOrderResponse = CheckOrderResponseModel.fromJson(jsonResponse);
    return checkOrderResponse.isInOrder;
  }

  void _validateResponse(HttpResponse response) {
    if (response.statusCode != 200) {
      throw Exception('A connection error occurred, try again.');
    }
  }
}
