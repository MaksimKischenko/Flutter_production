import 'package:flutter/material.dart';

class BpcDrawerHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const BpcDrawerHeader({
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) => DrawerHeader(
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400
            ),
          )
        ]
      ),
    ),
  );
}