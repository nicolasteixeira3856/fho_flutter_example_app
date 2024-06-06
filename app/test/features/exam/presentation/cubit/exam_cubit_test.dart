import 'package:bloc_test/bloc_test.dart';
import 'package:exam_app/features/exam/domain/entities/number_list.dart';
import 'package:exam_app/features/exam/domain/usecases/check_order_use_case.dart';
import 'package:exam_app/features/exam/domain/usecases/get_random_numbers_use_case.dart';
import 'package:exam_app/features/exam/presentation/cubit/exam_cubit.dart';
import 'package:exam_app/features/exam/presentation/cubit/exam_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRandomNumbersUseCase extends Mock
    implements GetRandomNumbersUseCase {}

class MockCheckOrderUseCase extends Mock implements CheckOrderUseCase {}

void main() {
  late ExamCubit cubit;
  late MockGetRandomNumbersUseCase mockGetRandomNumbers;
  late MockCheckOrderUseCase mockCheckOrder;

  setUp(() {
    mockGetRandomNumbers = MockGetRandomNumbersUseCase();
    mockCheckOrder = MockCheckOrderUseCase();
    cubit = ExamCubit(
      getRandomNumbersUseCase: mockGetRandomNumbers,
      checkOrderUseCase: mockCheckOrder,
    );
  });

  group('ExamCubit', () {
    const tQuantity = 5;
    final tNumbers = NumberList(numbers: [1, 2, 3, 4, 5]);

    blocTest<ExamCubit, ExamState>(
      'emits [ExamLoading, ExamLoaded] when fetchRandomNumbers is called successfully',
      build: () {
        when(() => mockGetRandomNumbers(any()))
            .thenAnswer((_) async => tNumbers);
        return cubit;
      },
      act: (cubit) => cubit.fetchRandomNumbers(tQuantity),
      expect: () => [
        ExamLoading(),
        ExamLoaded(numbers: tNumbers.numbers, isInOrder: null),
      ],
    );

    blocTest<ExamCubit, ExamState>(
      'emits [ExamLoading, ExamError] when fetchRandomNumbers fails',
      build: () {
        when(() => mockGetRandomNumbers(any()))
            .thenThrow(Exception('Failed to load data'));
        return cubit;
      },
      act: (cubit) => cubit.fetchRandomNumbers(tQuantity),
      expect: () => [
        ExamLoading(),
        ExamError('Exception: Failed to load data'),
      ],
    );

    blocTest<ExamCubit, ExamState>(
      'emits [ExamLoaded] when verifyOrder is called successfully',
      build: () {
        when(() => mockCheckOrder(any())).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.verifyOrder(tNumbers.numbers),
      expect: () => [
        ExamLoaded(numbers: tNumbers.numbers, isInOrder: true),
      ],
    );

    blocTest<ExamCubit, ExamState>(
      'emits [ExamError] when verifyOrder fails',
      build: () {
        when(() => mockCheckOrder(any()))
            .thenThrow(Exception('Failed to load data'));
        return cubit;
      },
      act: (cubit) => cubit.verifyOrder(tNumbers.numbers),
      expect: () => [
        ExamError('Exception: Failed to load data'),
      ],
    );

    blocTest<ExamCubit, ExamState>(
      'reorders numbers correctly when reorderNumbers is called',
      build: () => cubit,
      seed: () => ExamLoaded(numbers: const [1, 2, 3], isInOrder: null),
      act: (cubit) => cubit.reorderNumbers(0, 2),
      expect: () => [
        ExamLoaded(numbers: const [2, 1, 3], isInOrder: null),
      ],
    );
  });
}
