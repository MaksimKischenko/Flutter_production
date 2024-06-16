import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class ListTitle extends StatelessWidget {
  final String text;
  
  const ListTitle(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        color: AppStyles.mainTextColor.withOpacity(.5),
      ),
    ),
  );
}