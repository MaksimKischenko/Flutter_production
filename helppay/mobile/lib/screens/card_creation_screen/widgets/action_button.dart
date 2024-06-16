import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class CardCreationActionButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final double? fontSize;

  const CardCreationActionButton({
    required this.onTap,
    required this.title,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        highlightElevation: 0,
        minWidth: MediaQuery.of(context).size.width - 8,
        color: AppStyles.mainColor,
        disabledColor: const Color(0xff8498BC),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          // context.t.mobileScreens.mdomPollsListFilters.applyButton,
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize ?? 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
}
