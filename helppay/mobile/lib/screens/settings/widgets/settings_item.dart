import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsItem extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Widget? item;

  const SettingsItem({
    required this.onTap,
    required this.text,
    this.item
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xff383A51),
              fontSize: 18
            ),
          ),
         if (item == null) SvgPicture.asset(
            'assets/icon/arrow_right.svg'
          ) else item!
        ],
      ),
    ),
  );
}