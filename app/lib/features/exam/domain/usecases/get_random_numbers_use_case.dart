import '../entities/number_list.dart';
import '../repositories/exam_repository.dart';

abstract class GetRandomNumbersUseCase {
  Future<NumberList> call(int quantity);
}

class GetRandomNumbersUseCaseImpl implements GetRandomNumbersUseCase {
  final ExamRepository repository;

  GetRandomNumbersUseCaseImpl({required this.repository});

  @override
  Future<NumberList> call(int quantity) async {
    return await repository.getRandomNumbers(quantity);
  }
}
