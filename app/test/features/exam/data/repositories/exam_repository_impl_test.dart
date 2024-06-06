import 'package:exam_app/features/exam/data/datasources/exam_remote_datasource.dart';
import 'package:exam_app/features/exam/data/models/request/number_list_model.dart';
import 'package:exam_app/features/exam/data/repositories/exam_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamRemoteDataSource extends Mock implements ExamRemoteDataSource {}

void main() {
  late ExamRepositoryImpl repository;
  late MockExamRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockExamRemoteDataSource();
    repository = ExamRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('ExamRepositoryImpl', () {
    test(
        'should return NumberList when the call to remote data source is successful',
        () async {
      // Arrange
      const tQuantity = 5;
      final tNumbers = NumberListModel(numbers: [1, 2, 3, 4, 5]);
      when(() => mockRemoteDataSource.getRandomNumbers(any()))
          .thenAnswer((_) async => tNumbers);

      // Act
      final result = await repository.getRandomNumbers(tQuantity);

      // Assert
      expect(result, equals(tNumbers));
    });

    test('should return true when the numbers are in order', () async {
      // Arrange
      final tNumbers = [1, 2, 3, 4, 5];
      when(() => mockRemoteDataSource.checkOrder(any()))
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.checkOrder(tNumbers);

      // Assert
      expect(result, true);
    });

    test(
        'should throw an exception when the call to remote data source is unsuccessful for getRandomNumbers',
        () async {
      // Arrange
      const tQuantity = 5;
      when(() => mockRemoteDataSource.getRandomNumbers(any()))
          .thenThrow(Exception('Failed to load data'));

      // Act
      final call = repository.getRandomNumbers(tQuantity);

      // Assert
      expect(call, throwsException);
    });

    test(
        'should throw an exception when the call to remote data source is unsuccessful for checkOrder',
        () async {
      // Arrange
      final tNumbers = [1, 2, 3, 4, 5];
      when(() => mockRemoteDataSource.checkOrder(any()))
          .thenThrow(Exception('Failed to load data'));

      // Act
      final call = repository.checkOrder(tNumbers);

      // Assert
      expect(call, throwsException);
    });
  });
}
