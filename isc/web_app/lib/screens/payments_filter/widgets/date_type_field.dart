
import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';

class DateTypeField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const DateTypeField({
    required this.controller,
    this.onTap
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    onTap: onTap,
    readOnly: true,
    decoration: InputDecoration(
      labelText: 'Тип даты *',
        alignLabelWithHint: true,
        labelStyle: AppStyles.inputLabelUnderlineStyle,
        enabledBorder: AppStyles.inputBorderOutline,
        border: AppStyles.inputBorderOutline,
        errorBorder: AppStyles.errorWebBorder,
        focusedErrorBorder: AppStyles.errorWebBorder,
        isDense: true,         
      suffixIcon: const Icon(
        Icons.expand_more,
        color: AppStyles.mainColor,
      )
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'Выберите тип даты';
      }
      return null;
    }
  );
}