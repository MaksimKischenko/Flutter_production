import 'package:flutter/material.dart';

class CompanyName extends StatelessWidget {
  final String name;

  const CompanyName(this.name);

  @override
  Widget build(BuildContext context) => Text(
    name,
    style: const TextStyle(
      fontSize: 20,
      // fontWeight: FontWeight.bold,
      // height: 32
    ),
  );
}