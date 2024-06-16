import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class NextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;

  const NextButton({
    required this.text,
    required this.onPressed,
    this.color = AppStyles.mainColor
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    highlightElevation: 0,
    color: color,
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        // fontWeight: FontWeight.w400
      ),
    )
  );
}