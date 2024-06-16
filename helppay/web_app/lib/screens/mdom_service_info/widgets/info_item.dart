import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';


class InfoItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const InfoItem({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      // horizontal: 16,
      vertical: 4
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppStyles.mainColorDark.withOpacity(0.6),
            fontSize: 16
          )
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppStyles.mainColorDark,
            fontSize: 18
          )
        ),
      ],
    ),
  );
}
