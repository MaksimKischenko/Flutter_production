
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class SelectButton extends StatelessWidget {
  final bool active;
  final Function() onPressed;

  const SelectButton({
    required this.active,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
    // enableFeedback: false,
    onPressed: active? onPressed : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    highlightElevation: 0,
    minWidth: double.maxFinite,
    color:  AppStyles.mainColor,
    disabledColor: const Color(0xff8498BC),
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Text(
      context.t.mobileScreens.mdomCompanyChoise.selectButton,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300
      ),
    )
  );
}