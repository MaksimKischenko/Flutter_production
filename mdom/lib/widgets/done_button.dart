import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  final String title;
  final bool active;
  final Function() onPressed;

  const DoneButton({
    required this.active,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: () => active ? onPressed() : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        highlightElevation: 0,
        minWidth: double.maxFinite,
        color: active
            ? AppStyles.mainColor
            : AppStyles.mainColorDark.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
