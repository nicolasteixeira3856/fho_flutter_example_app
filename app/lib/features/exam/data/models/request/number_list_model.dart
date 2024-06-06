import 'package:equatable/equatable.dart';

import '../../../domain/entities/number_list.dart';

class NumberListModel extends NumberList with EquatableMixin {
  NumberListModel({required super.numbers});

  factory NumberListModel.fromJson(Map<String, dynamic> json) {
    return NumberListModel(numbers: List<int>.from(json['numbers']));
  }

  Map<String, dynamic> toJson() {
    return {'numbers': numbers};
  }

  @override
  List<Object?> get props => [numbers];
}
