import 'package:bpc/styles.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

class EmailCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool value) onTap;

  const EmailCheckBox({
    required this.value,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTap(!value),
            child: Text(
              'E-mail',
              style: TextStyle(
                color: value ? AppStyles.mainColor : null
              ),
            ),
          ),
        ),
        CustomCheckBox(
          borderRadius: 150,
          checkedFillColor: AppStyles.mainColor,
          borderColor: AppStyles.mainColor.withOpacity(.2),
          value: value,
          onChanged: onTap,
        )
      ],
    ),
  );
}