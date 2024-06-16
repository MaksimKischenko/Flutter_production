import 'package:bpc_nkfo/styles.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

class SaveCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool value)? onTap;

  const SaveCheckBox({
    required this.value,
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context) => Row(
    children: [
      CustomCheckBox(
        borderRadius: 150,
        checkedFillColor: AppStyles.mainColor,
        borderColor: AppStyles.mainColor.withOpacity(.2),
        value: value,
        onChanged: (it) => onTap?.call(it),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () => onTap?.call(!value),
          child: Text(
            'Запомнить меня',
            style: TextStyle(
              color: value
                  ? AppStyles.mainColor
                  : AppStyles.mainTextColor
          )
          ),
        ),
      )
    ],
  );
}