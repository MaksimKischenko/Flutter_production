import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class ApplyButton extends StatelessWidget {
  final Function() onPressed;
  final bool active;

  const ApplyButton({
    required this.onPressed,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: () {
      if (active) onPressed();
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    highlightElevation: 0,
    minWidth: double.maxFinite,
    color: active
        ? AppStyles.mainColor
        : AppStyles.mainColorDark.withOpacity(0.3),
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Text(
      context.t.mobileScreens.paymentsHistoryFilters.applyButton,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300
      ),
    )
  );
}