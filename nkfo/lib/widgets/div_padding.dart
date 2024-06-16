
import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DivPadding extends StatelessWidget {
  const DivPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Div(
    colL: 4,
    colM: 12,
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox()
    ),
  );
}