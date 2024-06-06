/*
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());
}
*/

import 'package:exam_app/features/exam/domain/usecases/check_order_use_case.dart';
import 'package:exam_app/features/exam/domain/usecases/get_random_numbers_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final GetRandomNumbersUseCase getRandomNumbersUseCase;
  final CheckOrderUseCase checkOrderUseCase;

  ExamCubit(
      {required this.getRandomNumbersUseCase,
      required this.checkOrderUseCase})
      : super(ExamInitial());

  Future<void> fetchRandomNumbers(int quantity) async {
    emit(ExamLoading());
    try {
      final numberList = await getRandomNumbersUseCase(quantity);
      emit(ExamLoaded(numbers: numberList.numbers, isInOrder: null));
    } catch (e) {
      if (e.toString().contains(
          'ClientException with SocketException: Connection refused')) {
        emit(ExamError('Falha de conexão, verifique se a API está rodando e a URL no arquivo .env e tente novamente.'));
        return;
      }
      emit(ExamError(e.toString()));
    }
  }

  Future<void> verifyOrder(List<int> numbers) async {
    try {
      final result = await checkOrderUseCase(numbers);
      emit(ExamLoaded(numbers: numbers, isInOrder: result));
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  void reorderNumbers(int oldIndex, int newIndex) {
    if (state is ExamLoaded) {
      final currentState = state as ExamLoaded;
      final updatedNumbers = List<int>.from(currentState.numbers);
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = updatedNumbers.removeAt(oldIndex);
      updatedNumbers.insert(newIndex, item);
      emit(ExamLoaded(numbers: updatedNumbers, isInOrder: null));
    }
  }
}
