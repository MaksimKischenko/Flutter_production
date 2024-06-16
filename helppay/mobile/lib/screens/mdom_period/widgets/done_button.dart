import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class DoneButton extends StatelessWidget {
  final bool active;
  final Function() onPressed;

  const DoneButton({
    required this.active,
    required this.onPressed
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
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Text(
      context.t.mobileScreens.mdomPediod.doneButton,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300
      ),
    )
  );
}