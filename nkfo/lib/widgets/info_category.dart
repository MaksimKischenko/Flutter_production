import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class InfoCategory extends StatelessWidget {
  final String text;
  
  const InfoCategory(this.text);

  @override
  Widget build(BuildContext context) => Div(
    colL: 12,
    colM: 12,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        text,
        style: AppStyles.headerTextStyleLess,
        overflow: TextOverflow.visible,
      ),
    ),
  );
}