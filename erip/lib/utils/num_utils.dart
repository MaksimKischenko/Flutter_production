import 'dart:math';

extension DoubleExtension on double {

  double roundFixed() {
    final mod = pow(10.0, 2); 
    return (this * mod).round().toDouble() / mod; 
  }
}