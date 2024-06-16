import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';


class ApplyFilterButton extends StatelessWidget {
  final Function() onTap;

  const ApplyFilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        highlightElevation: 0,
        minWidth: double.maxFinite,
        color: AppStyles.mainColor,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          context.t.mobileScreens.mdomPollsListFilters.applyButton,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
}
