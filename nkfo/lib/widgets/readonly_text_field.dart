import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class ReadOnlyTextField extends StatelessWidget {
  final String labelText;
  final Key? key;
  final GlobalKey<FormFieldState>? fieldKey;
  final String? initialValue;
  final bool isChangeStatus;
  final TextEditingController? controller;
  final String? prefix;
  final String? helperText;

  const ReadOnlyTextField({
    required this.labelText,
    this.key,
    this.fieldKey,
    this.initialValue,
    this.isChangeStatus = false,
    this.controller,
    this.prefix,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 350,
    child: TextFormField(
      key: fieldKey,
      cursorColor: AppStyles.mainColor,
      controller: controller,
      readOnly: true,
      initialValue: initialValue,
      textInputAction: TextInputAction.done,
      style: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
          borderRadius: BorderRadius.circular(5)
        ),
        alignLabelWithHint: true,
        filled: true,
        isDense: true,
        fillColor: isChangeStatus ? Colors.grey.shade300 : Colors.grey.shade600,
        labelText: labelText,
        prefixText: prefix,
        helperText: helperText,
        labelStyle: AppStyles.labelTextFieldStyle,
        hintStyle: const TextStyle(
          color: AppStyles.mainTextColor
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5)
        ),
      ),
    ),
  );
}