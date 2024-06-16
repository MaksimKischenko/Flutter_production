import 'package:flutter/material.dart';


class OrderCardActionButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final double? fontSize;

  const OrderCardActionButton({
    required this.onTap,
    required this.title,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
        highlightElevation: 0,
        minWidth: 115,
        color: const Color(0xffEAEEF6),
        disabledColor: Colors.grey.shade400,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          // context.t.mobileScreens.mdomPollsListFilters.applyButton,
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: const Color(0xff1E50A8),
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.w500,
            // height: 16 / 24,
          ),
        ),
      );
}
