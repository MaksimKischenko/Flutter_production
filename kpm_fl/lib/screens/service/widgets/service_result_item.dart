import 'package:flutter/material.dart';
import 'package:kpm_fl/styles.dart';

class ServiceResultItem extends StatelessWidget {
  final String title;
  final dynamic subtitle;

  const ServiceResultItem({
    required this.title,
    this.subtitle
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: AppStyles.secondaryTextColor,
          fontSize: 16,
          // letterSpacing: -0.5
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '$subtitle',
        style: const TextStyle(
          color: AppStyles.mainTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          // letterSpacing: -0.5
        ),
      ),
    ],
  );
}