import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NextButtonRedesign extends StatelessWidget {
  final String name;
  final Function() onTap;

  const NextButtonRedesign({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ResponsiveBuilder(builder: (context, sizingInformation) {
        return SizedBox(
          height: 48,
          width: sizingInformation.isMobile || sizingInformation.isTablet
              ? MediaQuery.of(context).size.width - 32
              : 173,
          child: MaterialButton(
            color: AppStyles.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF))),
                const SizedBox(width: 13),
                const Icon(CupertinoIcons.arrow_right,
                    color: Colors.white, size: 20),
              ],
            ),
          ),
        );
      });
}
