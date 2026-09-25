import 'dart:math';

class AngleHandler {
  AngleHandler._();

  static double degreesToRadians(int degrees) {
    return degrees * pi / 180;
  }

  static double radiansToDegrees(double radians) {
    return radians * 180 / pi;
  }
}
