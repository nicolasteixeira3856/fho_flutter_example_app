import 'package:equatable/equatable.dart';
import 'package:exam_app/features/exam/data/models/request/number_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberListModel', () {
    final tNumbers = [1, 2, 3, 4, 5];
    final tNumberListModel = NumberListModel(numbers: tNumbers);

    test('should have the correct props', () {
      // Assert
      expect(tNumberListModel.props, [tNumbers]);
    });

    test('should return a valid model from JSON', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'numbers': tNumbers,
      };

      // Act
      final result = NumberListModel.fromJson(jsonMap);

      // Assert
      expect(result, tNumberListModel);
    });

    test('should return a JSON map containing the proper data', () {
      // Act
      final result = tNumberListModel.toJson();

      // Assert
      final expectedJsonMap = {
        'numbers': tNumbers,
      };
      expect(result, expectedJsonMap);
    });

    test('should return true for the same values (Equatable)', () {
      // Arrange
      final tNumberListModel2 = NumberListModel(numbers: tNumbers);

      // Assert
      expect(tNumberListModel, tNumberListModel2);
    });

    test('should return false for different values (Equatable)', () {
      // Arrange
      final tNumberListModel2 = NumberListModel(numbers: [6, 7, 8, 9, 10]);

      // Assert
      expect(tNumberListModel == tNumberListModel2, false);
    });
  });
}
