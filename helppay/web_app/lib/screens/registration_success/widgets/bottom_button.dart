import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const BottomButton({
    required this.text,
    required this.onPressed
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
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300
      ),
    )
  );
}