import 'dart:math';

class MathUtils {
  MathUtils._();

  static double randomValueFromRange(double min, double max) {
    Random random = Random();
    return min + random.nextDouble() * (max - min);
  }
}
