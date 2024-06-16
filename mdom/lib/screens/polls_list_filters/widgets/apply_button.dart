import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class ApplyButton extends StatelessWidget {
  final Function() onTap;

  const ApplyButton({
    required this.onTap
  });

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
    child: const Text(
      'Применить',
      // TODO
      // context.t.screens.mdomPollsListFilters.applyButton,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300
      ),
    )
  );
}