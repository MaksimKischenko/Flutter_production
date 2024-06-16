import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CabinetMenuWidget extends StatelessWidget {
  final Function() onTap;
  final IconData? icon;
  final String text;
  final bool selected;

  const CabinetMenuWidget({
    required this.onTap,
    this.icon,
    required this.text,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
    builder: (context, sizingInformation) {
      if (sizingInformation.screenSize.width < 768) {
      // if (sizingInformation.screenSize.width < 1024) {
        // small button. only icon
        return InkWell(
          onTap: selected ? null : onTap,
          child: Tooltip(
            message: text,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  // color: Colors.primaries[Random().nextInt(16)],
                  child: Icon(
                    icon ?? Icons.error,
                    color: selected ? AppStyles.mainColor : AppStyles.mainTextColor
                  ),
                ),
                if (selected)
                  Positioned.fill(
                    top: 66,
                    left: 12,
                    right: 12,
                    child: Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        // color: Colors.black,
                        color: AppStyles.mainColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        )
                      ),
                      // height: 4,
                    )
                  ),
              ],
            ),
          ),
        );
      } else {
        // large button
        return InkWell(
          onTap: selected ? null : onTap,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w400,
                    color: AppStyles.mainTextColor
                  ),
                )
                // child: Row(
                //   children: [
                //     if (icon != null)
                //     Padding(
                //       padding: const EdgeInsets.only(right: 12),
                //       child: Icon(
                //         icon,
                //         color: AppStyles.mainTextColor
                //       ),
                //     ),
                //     Text(
                //       text,
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: selected ? FontWeight.bold : FontWeight.w400,
                //         color: AppStyles.mainTextColor
                //       ),
                //     )
                //   ],
                // ),
              ),
              if (selected)
                Positioned.fill(
                  top: 66,
                  left: 16,
                  right: 16,
                  child: Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      // color: Colors.black,
                      color: AppStyles.mainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      )
                    ),
                    // height: 4,
                  )
                ),
            ],
          ),
        );
      }
    },
  );


}