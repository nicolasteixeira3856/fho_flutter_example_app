import 'package:bloc_test/bloc_test.dart';
import 'package:exam_app/features/exam/presentation/cubit/exam_cubit.dart';
import 'package:exam_app/features/exam/presentation/cubit/exam_state.dart';
import 'package:exam_app/features/exam/presentation/pages/random_numbers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExamCubit extends MockCubit<ExamState> implements ExamCubit {}

void main() {
  late MockExamCubit mockCubit;

  setUp(() {
    mockCubit = MockExamCubit();
  });

  testWidgets(
      'RandomNumbersPage should display loading indicator when state is ExamLoading',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockCubit.state).thenReturn(ExamLoading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ExamCubit>(
          create: (context) => mockCubit,
          child: const RandomNumbersPage(quantity: 5),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'RandomNumbersPage should display list of numbers when state is ExamLoaded',
      (WidgetTester tester) async {
    // Arrange
    final tNumbers = [1, 2, 3, 4, 5];
    when(() => mockCubit.state)
        .thenReturn(ExamLoaded(numbers: tNumbers, isInOrder: null));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ExamCubit>(
          create: (context) => mockCubit,
          child: const RandomNumbersPage(quantity: 5),
        ),
      ),
    );

    // Assert
    for (final number in tNumbers) {
      expect(find.text(number.toString()), findsOneWidget);
    }
  });

  testWidgets(
      'RandomNumbersPage should display error message when state is ExamError',
      (WidgetTester tester) async {
    // Arrange
    const tMessage = 'Something went wrong';
    when(() => mockCubit.state).thenReturn(ExamError(tMessage));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ExamCubit>(
          create: (context) => mockCubit,
          child: const RandomNumbersPage(quantity: 5),
        ),
      ),
    );

    // Assert
    expect(find.text(tMessage), findsOneWidget);
  });
}
