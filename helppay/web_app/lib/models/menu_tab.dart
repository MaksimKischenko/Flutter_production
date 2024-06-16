import 'package:flutter/widgets.dart';

enum MenuTab {
  qrScan,
  paymentsHistory,
  products,
  profile,
  accruals
}

class MenuTabWrapper {
  final MenuTab tab;
  final Widget child;

  const MenuTabWrapper({
    required this.tab,
    required this.child,
  });
}
