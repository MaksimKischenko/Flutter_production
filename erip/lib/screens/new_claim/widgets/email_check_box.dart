import 'package:bpc_nkfo/styles.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

class EmailCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool value)? onTap;

  const EmailCheckBox({
    required this.value,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () => onTap?.call(!value),
          child: !value
            ? const Text('E-mail')
            : const Text(
              'E-mail',
              style: TextStyle(
                color: AppStyles.mainColor
              ),
            ),
        )
      ),
      CustomCheckBox(
        borderRadius: 150,
        checkedFillColor: AppStyles.mainColor,
        borderColor: AppStyles.mainColor.withOpacity(.2),
        value: value,
        onChanged: (it) => onTap?.call(it),
      )
    ],
  );
}