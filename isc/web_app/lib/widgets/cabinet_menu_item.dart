import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';


class CabinetMenuItem extends StatelessWidget {
  final Function() onTap;
  final String? iconName;
  final IconData? icon;  
  final String text;
  final bool selected;

  const CabinetMenuItem({
    required this.onTap,
    required this.text,
    this.iconName,
    this.icon,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
    builder: (context, sizingInformation) {
      if (sizingInformation.screenSize.width < 1000) {
        return Tooltip(
          message: text,
          child: TextButton(
            onPressed: selected ? null : onTap,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  icon ?? Icons.error,
                  color: selected ? AppStyles.mainColor : AppStyles.cabinetMenuTextColor
                ),         
            ),
          ),
        );
      } else {
        return TextButton(
          onPressed: selected ? null : onTap,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: selected ? const Border(
                bottom: BorderSide(
                  color: AppStyles.mainColor,
                  width: 2
                )
              ) : null
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selected? FontWeight.w600 : FontWeight.w300,
                color:AppStyles.cabinetMenuTextColor 
              ),
            ),
          ),
        );
      }
    },
  );
}

