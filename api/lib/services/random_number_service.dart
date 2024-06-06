import 'dart:math';

class RandomNumberService {
  List<int> generateRandomNumbers(int quantity) {
    final random = Random();
    final numbers = <int>{};

    while (numbers.length < quantity) {
      numbers.add(random.nextInt(100));
    }

    return numbers.toList();
  }
}
