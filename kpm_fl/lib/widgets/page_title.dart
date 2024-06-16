import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 32
    ),
  );
}
