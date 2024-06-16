import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckButton extends StatelessWidget {
  final String name;
  final Function()? onTap;

  const CheckButton({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ResponsiveBuilder(builder: (context, sizingInformation) {
        return SizedBox(
          height: 48,
          width: 118,
          child: MaterialButton(
            color: AppStyles.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onPressed: onTap,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFFFFF)
              )
            ),
          ),
        );
      });
}
