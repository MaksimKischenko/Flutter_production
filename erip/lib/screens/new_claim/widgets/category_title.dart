import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String text;

  const CategoryTitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: AppStyles.mainColor.withOpacity(0.8),
      fontSize: 16,
      fontWeight: FontWeight.bold
    ),
  );
}