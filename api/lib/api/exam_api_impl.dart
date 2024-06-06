import 'package:exam_api/services/random_number_service.dart';
import 'package:exam_api/services/order_check_service.dart';
import 'exam_api.dart';

class ExamApiImpl implements ExamApi {
  final RandomNumberService _randomNumberService;
  final OrderCheckService _orderCheckService;

  ExamApiImpl(this._randomNumberService, this._orderCheckService);

  @override
  List<int> getRandomNumbers(int quantity) {
    return _randomNumberService.generateRandomNumbers(quantity);
  }

  @override
  bool checkOrder(List<int> numbers) {
    return _orderCheckService.isInOrder(numbers);
  }
}
