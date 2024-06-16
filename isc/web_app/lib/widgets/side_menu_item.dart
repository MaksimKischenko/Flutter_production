import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';


class SideMenuItem extends StatelessWidget {
  final String text;
  final bool selected;
  final Function() onTap;

  const SideMenuItem({
    required this.text,
    required this.onTap,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: selected
              ? AppStyles.secondaryColor
              : Colors.transparent,
            width: 4
          )
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? AppStyles.secondaryColor : AppStyles.mainTextColor,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          fontSize: 18
        ),
      ),
    ),
  );
}