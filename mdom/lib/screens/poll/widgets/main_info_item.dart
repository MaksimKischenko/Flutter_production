import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class MainInfoItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final String? trailingText;
  final VoidCallback? onTap;

  const MainInfoItem({
    Key? key,
    this.icon,
    required this.text,
    this.trailingText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppStyles.mainColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: Row(
        children: [
          if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              icon,
              color: AppStyles.secondaryColor,
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16
              ),
            ),
          ),
          if (trailingText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              trailingText!,
              style: const TextStyle(
                fontSize: 16
              ),
            )
          ),
          if (onTap != null)
          const Padding(
            padding: EdgeInsets.only(left: 4, right: 8),
            child: Icon(
              Icons.chevron_right_rounded,
              color: Color(0xffDDE1E9),
              size: 24,
            ),
          ),
          if (onTap == null)
          const SizedBox(width: 16),
        ],
      ),
    ),
  );
}