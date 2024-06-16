import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';

class CompanyName extends StatelessWidget {
  final String name;

  const CompanyName(this.name);

  @override
  Widget build(BuildContext context) => Text(
    name,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppStyles.cabinetMenuTextColor
    ),
  );
}