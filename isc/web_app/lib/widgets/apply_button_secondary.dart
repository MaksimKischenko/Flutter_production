import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';


class ApplyButtonSecondary extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ApplyButtonSecondary({
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: AppStyles.mainColor.withOpacity(0.2)
      )
    ),
    elevation: 0,
    highlightElevation: 0,
    minWidth: double.maxFinite,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Text(
      text,
      style: const TextStyle(
        color: AppStyles.mainColorDark,
        fontSize: 16,
        fontWeight: FontWeight.w400
      ),
    )
  );
}