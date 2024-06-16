import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';


class ApplyButtonSecondary extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ApplyButtonSecondary({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) => MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppStyles.mainColor.withOpacity(0.2))),
      elevation: 0,
      highlightElevation: 0,
      minWidth: double.maxFinite,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        text,
        style: const TextStyle(
            color: AppStyles.mainColorDark,
            fontSize: 18,
            fontWeight: FontWeight.w300),
      ));
}
