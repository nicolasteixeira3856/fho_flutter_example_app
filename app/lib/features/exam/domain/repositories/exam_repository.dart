import '../entities/number_list.dart';

abstract class ExamRepository {
  Future<NumberList> getRandomNumbers(int quantity);
  Future<bool> checkOrder(List<int> numbers);
}