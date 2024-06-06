import 'package:exam_app/features/exam/domain/entities/number_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberList Entity', () {
    test('should correctly instantiate with a list of numbers', () {
      // Arrange
      final numbers = [1, 2, 3, 4, 5];

      // Act
      final numberList = NumberList(numbers: numbers);

      // Assert
      expect(numberList.numbers, numbers);
    });
  });
}
