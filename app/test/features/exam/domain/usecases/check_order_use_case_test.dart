import 'package:exam_app/features/exam/domain/repositories/exam_repository.dart';
import 'package:exam_app/features/exam/domain/usecases/check_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamRepository extends Mock implements ExamRepository {}

void main() {
  late CheckOrderUseCase usecase;
  late MockExamRepository mockRepository;

  setUp(() {
    mockRepository = MockExamRepository();
    usecase = CheckOrderUseCaseImpl(repository: mockRepository);
  });

  test('should check if numbers are in order from the repository', () async {
    // Arrange
    final tNumbers = [1, 2, 3, 4, 5];
    when(() => mockRepository.checkOrder(any())).thenAnswer((_) async => true);

    // Act
    final result = await usecase(tNumbers);

    // Assert
    expect(result, true);
    verify(() => mockRepository.checkOrder(tNumbers)).called(1);
  });
}
