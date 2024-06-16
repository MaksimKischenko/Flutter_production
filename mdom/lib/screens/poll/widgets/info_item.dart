import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isUrl;
  final VoidCallback? onTap;

  const InfoItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.isUrl = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppStyles.mainTextColor.withOpacity(.5),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 17,
              color: isUrl ? const Color(0xff1E50A8) : null
            ),
          ),
        ],
      ),
    ),
  );
}