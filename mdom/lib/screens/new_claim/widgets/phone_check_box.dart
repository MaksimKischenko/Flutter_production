import 'package:bpc/styles.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

class PhoneCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool value) onTap;

  const PhoneCheckBox({
    required this.value,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => onTap(!value),
    child: Row(
      children: [
        Expanded(
          child: Text(
            'SMS',
            style: TextStyle(
              color: value ? AppStyles.mainColor : null,
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