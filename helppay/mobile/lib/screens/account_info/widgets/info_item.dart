import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class InfoItem extends StatelessWidget {
  final MapEntry<String, String> item;

  const InfoItem(this.item);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.key,
          style: TextStyle(
            fontSize: 16,
            color: AppStyles.mainColorDark.withOpacity(0.6)
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.value,
          style: const TextStyle(
            fontSize: 17,
            color: AppStyles.mainColorDark
          ),
        )
      ],
    ),
  );
}