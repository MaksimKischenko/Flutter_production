import 'package:flutter/material.dart';

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
      color: Color(0xff383A51),
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -1.4
    ),
  );
}