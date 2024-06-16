import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: -0.2,
        color: AppStyles.mainColorDark.withOpacity(0.7)
      ),
    ),
  );
}