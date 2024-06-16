import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class DivWithPadding extends StatelessWidget {
  final Widget child;
  const DivWithPadding({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Div6to12(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: child,
        ),
      );
}
