import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ReturnButton extends StatelessWidget {
  final Function() onTap;
  final String name;

  const ReturnButton({
    Key? key,
    this.name = 'Назад',
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return SizedBox(
            height: 48,
            width: sizingInformation.isMobile || sizingInformation.isTablet
                ? MediaQuery.of(context).size.width - 32
                : 124,
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppStyles.mainColor),
                  borderRadius: BorderRadius.circular(6)),
              onPressed: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_left,
                      color: AppStyles.mainColor, size: 20),
                  SizedBox(width: 13),
                  Text(name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppStyles.mainColor)),
                ],
              ),
            ),
          );
        },
      );
}
