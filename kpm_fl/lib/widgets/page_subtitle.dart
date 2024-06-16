import 'package:flutter/material.dart';
import 'package:kpm_fl/styles.dart';

class PageSubtitle extends StatelessWidget {
  final String text;

  const PageSubtitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: AppStyles.secondaryTextColor
    )
  );
}