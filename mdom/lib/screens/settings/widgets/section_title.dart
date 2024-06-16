import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        color: AppStyles.mainTextColor.withOpacity(0.6),
        fontSize: 16
      ),
    ),
  );
}