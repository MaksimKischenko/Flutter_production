import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';

class InfotItem extends StatelessWidget {
  final String title;
  final dynamic subtitle;

  const InfotItem({
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(
      title,
      style: TextStyle(
        color: AppStyles.mainTextColor.withOpacity(0.7),
        fontSize: 14
      ),
    ),
    subtitle: Text(
      subtitle.toString(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppStyles.mainTextColor,
        fontSize: 16
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    dense: true,
  );
}