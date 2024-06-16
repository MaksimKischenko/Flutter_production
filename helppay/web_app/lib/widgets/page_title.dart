import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle({
    Key? key,
    required this.text
  }): super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: AppStyles.cabinetMenuTextColor,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
  );
}