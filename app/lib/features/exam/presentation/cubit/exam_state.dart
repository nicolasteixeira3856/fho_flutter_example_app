import 'package:equatable/equatable.dart';

abstract class ExamState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final List<int> numbers;
  final bool? isInOrder;

  ExamLoaded({required this.numbers, this.isInOrder});

  @override
  List<Object?> get props => [numbers, isInOrder];
}

class ExamError extends ExamState {
  final String message;

  ExamError(this.message);

  @override
  List<Object?> get props => [message];
}