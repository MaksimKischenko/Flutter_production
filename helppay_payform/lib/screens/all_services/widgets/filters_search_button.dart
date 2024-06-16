import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class FiltersSearchButton extends StatelessWidget {
  final Function() onTap;

  const FiltersSearchButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: onTap,
        color: AppStyles.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: const Text(
          'Найти',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
}
