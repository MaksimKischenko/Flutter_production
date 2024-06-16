import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class NextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const NextButton({
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
    color: AppStyles.mainColor,
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600
      ),
    )
  );
}