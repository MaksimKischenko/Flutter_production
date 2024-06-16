import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final Color color;
  final String text;

  const InfoItem({
    required this.color,
    required this.text
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Container(
          color: color,
          width: 16,
          height: 28,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16
          ),
        ),
      ],
    ),
  );
}