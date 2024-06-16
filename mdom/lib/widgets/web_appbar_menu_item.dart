import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppbarWebMenuItem extends StatelessWidget {
  final Function() onTap;
  final String? iconName;
  final String text;
  final bool selected;

  const AppbarWebMenuItem({
    required this.onTap,
    required this.text,
    this.iconName,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.screenSize.width < 1400) {
            return Tooltip(
              message: text,
              child: TextButton(
                onPressed: selected ? null : onTap,
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(const Color(0xffEDF6FF))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(
                    'assets/icon/$iconName.svg',
                    color: selected
                        ? AppStyles.secondaryColor
                        : AppStyles.mainTextColor,
                  ),
                ),
              ),
            );
          } else {
            return TextButton(
              onPressed: selected ? null : onTap,
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(const Color(0xffEDF6FF))),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    border: selected
                        ? const Border(
                            bottom: BorderSide(
                                color: AppStyles.secondaryColor, width: 2))
                        : null),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w300,
                      color: AppStyles.mainTextColor),
                ),
              ),
            );
          }
        },
      );
}
