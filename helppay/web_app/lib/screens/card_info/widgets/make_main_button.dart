import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class MakeMainButton extends StatelessWidget {
  final Function() onPressed;

  const MakeMainButton({
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
    padding: const EdgeInsets.symmetric(vertical: 20),
    child:  Text(
      context.t.mobileScreens.cardInfo.makeMainButton,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500
      ),
    )
  );
}