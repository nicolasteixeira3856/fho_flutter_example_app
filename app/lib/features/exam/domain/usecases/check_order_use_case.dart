import '../repositories/exam_repository.dart';

abstract class CheckOrderUseCase {
  Future<bool> call(List<int> numbers);
}

class CheckOrderUseCaseImpl implements CheckOrderUseCase {
  final ExamRepository repository;

  CheckOrderUseCaseImpl({required this.repository});

  @override
  Future<bool> call(List<int> numbers) async {
    return await repository.checkOrder(numbers);
  }
}
