import 'package:flutter/material.dart';
import 'package:kpm_fl/models/models.dart';
import 'package:kpm_fl/styles.dart';

class SettingsField extends StatelessWidget {
  final String title;
  final String initialValue;
  final ParamType type;
  final Function(String value) onSaved;

  const SettingsField({
    Key? key,
    required this.title,
    required this.initialValue,
    this.type = ParamType.str,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    initialValue: initialValue,
    inputFormatters: type.inputFormatters,
    decoration: InputDecoration(
      labelText: title,
      alignLabelWithHint: true,
      isDense: true,
      labelStyle: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      hintStyle: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      border: AppStyles.inputBorder,
      focusedBorder: AppStyles.inputBorderFocused,
      enabledBorder: AppStyles.inputBorderEnabled
    ),
    validator: (value) {
      if (value == null) return 'Неизвестная ошибка';

      if (value.isEmpty) return 'Поле обязательно для заполнения';

      return type.validator(value);

      // return null;
    },
    onSaved: (value) => onSaved(value!),
  );
}
