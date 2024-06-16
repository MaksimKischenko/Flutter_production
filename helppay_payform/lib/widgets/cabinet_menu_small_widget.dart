import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class CabinetMenuSmallWidget extends StatelessWidget {
  final Function() onTap;
  final IconData? icon;
  final String text;
  final bool selected;

  const CabinetMenuSmallWidget({
    required this.onTap,
    this.icon,
    required this.text,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: selected ? null : onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? AppStyles.mainColor : Colors.white
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: selected ? FontWeight.bold : FontWeight.w400,
              color: AppStyles.mainTextColor
            ),
          ),
        ],
      ),
    ),
  );


}