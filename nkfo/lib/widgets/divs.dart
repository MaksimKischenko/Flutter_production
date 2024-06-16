import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class Div6to12 extends StatelessWidget {
  final Widget child;
  const Div6to12({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Div(
        colL: 6,
        colM: 12,
        child: child,
      );
}
