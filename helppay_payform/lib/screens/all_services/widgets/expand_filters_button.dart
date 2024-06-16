import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class ExpandFiltersButton extends StatelessWidget {
  final bool isExpanded;
  final Function(bool newValue) onTap;

  const ExpandFiltersButton({
    Key? key,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => onTap(!isExpanded),
    child: Row(
      children: [
        const Text(
          'Расширенный поиск',
          style: TextStyle(
            color: AppStyles.mainColor,
            fontSize: 16,
            // fontWeight: FontWeight.bold.
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          isExpanded
          ? Icons.keyboard_arrow_up_rounded
          : Icons.keyboard_arrow_down_rounded,
          color: AppStyles.mainColor,
          size: 18,
        )
      ],
    ),
  );
}
