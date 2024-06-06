import 'package:equatable/equatable.dart';

class CheckOrderResponseModel extends Equatable {
  final bool isInOrder;

  const CheckOrderResponseModel({required this.isInOrder});

  factory CheckOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckOrderResponseModel(isInOrder: json['isInOrder']);
  }

  Map<String, dynamic> toJson() {
    return {'isInOrder': isInOrder};
  }

  @override
  List<Object?> get props => [isInOrder];
}
