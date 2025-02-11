import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerItemSvg extends StatelessWidget {
  final bool selected;
  final String assetName;
  final String text;
  final Function() onTap;

  const DrawerItemSvg({
    required this.selected,
    required this.assetName,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => ListTile(
    selected: selected,
    leading: Padding(
      padding: const EdgeInsets.only(left: 2),
      child: SvgPicture.asset(
        'assets/icon/$assetName.svg',
        width: 24,
        height: 24,
        semanticsLabel: text,
        colorFilter: selected
            ? const ColorFilter.mode(AppStyles.mainColor, BlendMode.srcIn)
            : null,
      ),
    ),
    title: Text(
      text,
      style: TextStyle(
        color: selected
            ? AppStyles.mainColor
            : AppStyles.mainTextColor,
        // fontSize: 14
      ),
    ),
    onTap: onTap,
  );
}