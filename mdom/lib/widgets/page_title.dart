import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle({
    Key? key,
    required this.text
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: 2,
    style: const TextStyle(
      color: AppStyles.mainTextColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.4,
      overflow: TextOverflow.ellipsis
    ),
  );
}