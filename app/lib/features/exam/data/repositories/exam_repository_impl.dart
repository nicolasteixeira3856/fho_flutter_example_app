import '../../domain/entities/number_list.dart';
import '../../domain/repositories/exam_repository.dart';
import '../datasources/exam_remote_datasource.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamRemoteDataSource remoteDataSource;

  ExamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<NumberList> getRandomNumbers(int quantity) async {
    return await remoteDataSource.getRandomNumbers(quantity);
  }

  @override
  Future<bool> checkOrder(List<int> numbers) async {
    return await remoteDataSource.checkOrder(numbers);
  }
}
