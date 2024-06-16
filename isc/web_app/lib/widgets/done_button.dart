import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';

class DoneButton extends StatefulWidget {
  final String title;
  final bool active;
  final Function() onPressed;

  const DoneButton({
    required this.active,
    required this.onPressed,
    required this.title,
  });

  @override
  State<DoneButton> createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: () => widget.active ? widget.onPressed() : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        highlightElevation: 0,
        minWidth: double.maxFinite,
        color: widget.active
            ? AppStyles.mainColor
            : AppStyles.mainColorDark.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
