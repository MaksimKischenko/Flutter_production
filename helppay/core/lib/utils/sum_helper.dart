extension SumHelper on double {

  String format() => toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  
}