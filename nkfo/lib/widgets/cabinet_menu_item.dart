import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class CabinetMenuItem extends StatelessWidget {
  final Function() onTap;
  final IconData? icon;
  final String text;
  final bool selected;

  const CabinetMenuItem({
    required this.onTap,
    required this.text,
    this.icon,
    this.selected = false
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
              overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              decoration: BoxDecoration(
                border: selected ? const Border(
                  bottom: BorderSide(
                    color: AppStyles.mainColor,
                    width: 3
                  )
                ) : null
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  icon ?? Icons.error,
                  color: selected ? AppStyles.mainColor : AppStyles.mainTextColor
                ),
              ),
            ),
          ),
        );
      } else {
        // large button
        return TextButton(
          onPressed: selected ? null : onTap,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            decoration: BoxDecoration(
              border: selected ? const Border(
                bottom: BorderSide(
                  color: AppStyles.mainColor,
                  width: 3
                )
              ) : null
            ),
            child: Row(
              children: [
                if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    icon,
                    color: selected ? AppStyles.mainColor : AppStyles.mainTextColor
                  ),
                ),
                Text(
                  text,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: selected ? AppStyles.mainColor : AppStyles.mainTextColor
                  ),
                )
              ],
            ),
          ),
        );
      }
    },
  );
}

