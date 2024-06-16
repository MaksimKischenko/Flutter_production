import 'package:flutter/widgets.dart';

enum MenuTab {
  // organization,
  claims,
  payments,
  servicesQr,
  polls,
  more,
}

class MenuTabWrapper {
  final MenuTab tab;
  final Widget child;

  const MenuTabWrapper({
    required this.tab,
    required this.child,
  });
}
