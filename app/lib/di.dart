import 'package:exam_app/features/exam/domain/repositories/exam_repository.dart';
import 'package:exam_app/features/exam/domain/usecases/check_order_use_case.dart';
import 'package:exam_app/features/exam/domain/usecases/get_random_numbers_use_case.dart';
import 'package:get_it/get_it.dart';

import 'core/network/http_client_impl.dart';
import 'features/exam/data/datasources/exam_remote_datasource.dart';
import 'features/exam/data/repositories/exam_repository_impl.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void initializeDependencyInjection() {
  getIt.registerLazySingleton(() => HttpClientImpl(client: http.Client()));
  getIt.registerLazySingleton<ExamRemoteDataSource>(
      () => ExamRemoteDataSourceImpl(httpClient: getIt<HttpClientImpl>()));
  getIt.registerLazySingleton<ExamRepository>(() =>
      ExamRepositoryImpl(remoteDataSource: getIt<ExamRemoteDataSource>()));

  getIt.registerFactory<GetRandomNumbersUseCase>(
      () => GetRandomNumbersUseCaseImpl(repository: getIt<ExamRepository>()));
  getIt.registerFactory<CheckOrderUseCase>(
      () => CheckOrderUseCaseImpl(repository: getIt<ExamRepository>()));
}
