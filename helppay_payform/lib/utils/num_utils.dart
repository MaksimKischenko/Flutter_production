import 'dart:math';

extension DoubleExtension on double {
  // fixed double round method
  double fixedRound(){ 
    final mod = pow(10.0, 2).toDouble(); 
    return (this * mod).round().toDouble() / mod; 
  }
}