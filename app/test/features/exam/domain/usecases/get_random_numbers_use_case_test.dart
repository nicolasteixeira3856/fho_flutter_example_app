import 'package:exam_app/features/exam/domain/entities/number_list.dart';
import 'package:exam_app/features/exam/domain/repositories/exam_repository.dart';
import 'package:exam_app/features/exam/domain/usecases/get_random_numbers_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamRepository extends Mock implements ExamRepository {}

void main() {
  late GetRandomNumbersUseCase usecase;
  late MockExamRepository mockRepository;

  setUp(() {
    mockRepository = MockExamRepository();
    usecase = GetRandomNumbersUseCaseImpl(repository: mockRepository);
  });

  test('should get random numbers from the repository', () async {
    // Arrange
    const tQuantity = 5;
    final tNumbers = NumberList(numbers: [1, 2, 3, 4, 5]);
    when(() => mockRepository.getRandomNumbers(any()))
        .thenAnswer((_) async => tNumbers);

    // Act
    final result = await usecase(tQuantity);

    // Assert
    expect(result, tNumbers);
    verify(() => mockRepository.getRandomNumbers(tQuantity)).called(1);
  });
}
