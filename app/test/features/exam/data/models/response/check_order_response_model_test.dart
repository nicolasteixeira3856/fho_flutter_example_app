import 'package:exam_app/features/exam/data/models/response/check_order_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckOrderResponseModel', () {
    const tIsInOrder = true;
    const tCheckOrderResponseModel =
        CheckOrderResponseModel(isInOrder: tIsInOrder);

    test('should have the correct props', () {
      // Assert
      expect(tCheckOrderResponseModel.props, [tIsInOrder]);
    });

    test('should return a valid model from JSON', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'isInOrder': tIsInOrder,
      };

      // Act
      final result = CheckOrderResponseModel.fromJson(jsonMap);

      // Assert
      expect(result, tCheckOrderResponseModel);
    });

    test('should return a JSON map containing the proper data', () {
      // Act
      final result = tCheckOrderResponseModel.toJson();

      // Assert
      final expectedJsonMap = {
        'isInOrder': tIsInOrder,
      };
      expect(result, expectedJsonMap);
    });

    test('should return true for the same values (Equatable)', () {
      // Arrange
      const tCheckOrderResponseModel2 =
          CheckOrderResponseModel(isInOrder: tIsInOrder);

      // Assert
      expect(tCheckOrderResponseModel, tCheckOrderResponseModel2);
    });

    test('should return false for different values (Equatable)', () {
      // Arrange
      const tCheckOrderResponseModel2 =
          CheckOrderResponseModel(isInOrder: false);

      // Assert
      expect(tCheckOrderResponseModel == tCheckOrderResponseModel2, false);
    });
  });
}
