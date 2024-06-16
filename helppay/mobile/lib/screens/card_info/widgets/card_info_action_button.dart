import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class CardInfoActionButton extends StatelessWidget {
  final Function() onPressed;
  final String title;

  const CardInfoActionButton({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      highlightElevation: 0,
      minWidth: double.maxFinite,
      color: AppStyles.mainColor,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ));
}
