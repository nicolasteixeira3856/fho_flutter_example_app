import 'package:test/test.dart';
import 'package:exam_api/api/exam_api_impl.dart';
import 'package:exam_api/services/random_number_service.dart';
import 'package:exam_api/services/order_check_service.dart';

void main() {
  group('ExamApi Tests', () {
    final randomNumberService = RandomNumberService();
    final orderCheckService = OrderCheckService();
    final examApi = ExamApiImpl(randomNumberService, orderCheckService);

    test('getRandomNumbers returns correct quantity', () {
      final numbers = examApi.getRandomNumbers(5);
      expect(numbers.length, 5);
    });

    test('getRandomNumbers returns unique numbers', () {
      final numbers = examApi.getRandomNumbers(100);
      final uniqueNumbers = numbers.toSet();
      expect(numbers.length, uniqueNumbers.length);
    });

    test('checkOrder returns true for ordered list', () {
      final orderedList = [1, 2, 3, 4, 5];
      final result = examApi.checkOrder(orderedList);
      expect(result, isTrue);
    });

    test('checkOrder returns false for unordered list', () {
      final unorderedList = [5, 3, 1, 4, 2];
      final result = examApi.checkOrder(unorderedList);
      expect(result, isFalse);
    });
  });
}
