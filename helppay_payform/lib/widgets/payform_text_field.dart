import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_payform_app/styles.dart';

class HelppayTextField extends StatelessWidget {
  final Key? key;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String value)? onSaved;
  final TextInputFormatter? formatter;
  final Function(String?)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String)? validator;
  final int? maxLines;

  const HelppayTextField({
    this.key,
    this.keyboardType,
    this.focusNode,
    this.initialValue,
    this.controller,
    this.onSaved,
    this.formatter,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    keyboardType: keyboardType,
    focusNode: focusNode,
    cursorColor: AppStyles.mainColor,
    controller: controller,
    inputFormatters: formatter != null ? [formatter!] : [],
    autocorrect: false,  
    initialValue: initialValue,
    minLines: 1,
    maxLines: maxLines,
    textInputAction: TextInputAction.done,
    style: const TextStyle(
      color: AppStyles.mainTextColor
    ),
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
        borderRadius: BorderRadius.circular(6)
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1)
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1)
      ),
      errorStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),      
      alignLabelWithHint: true,
      filled: true,
      isDense: true,
      labelStyle: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      hintStyle: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xff333333), width: 1),
        borderRadius: BorderRadius.circular(6)
      )
    ),
    validator: (value) => validator?.call(value!),
    onSaved: (value) => onSaved?.call(value!),
  );
}