
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:payment_tracking_module/presentation/styles.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final GlobalKey<FormFieldState>? fieldKey;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool isReadOnly;
  final TextEditingController? controller;
  final bool mandatory;
  final Function(String value)? onSaved;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefix;
  final String? hint;
  final Function(String?)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String)? validator;
  final String? helperText;
  final int? minLines;
  final int? maxLines;

  const InputField({
    Key? key,
    required this.labelText,
    this.fieldKey,
    this.focusNode,
    this.initialValue,
    this.isReadOnly = false,
    this.controller,
    this.mandatory = false,
    this.onSaved,
    this.maxLength,
    this.inputFormatters,
    this.prefix,
    this.hint,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.helperText,
    this.maxLines = 1,
    this.minLines = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    cursorColor: AppStyles.colorDark,
    controller: controller,
    key: fieldKey,
    focusNode: focusNode,
    autocorrect: false,  
    cursorWidth: 1,
    textInputAction: TextInputAction.done,
    style: AppStyles.textStyleBlackTextFieldsContent,
    inputFormatters: inputFormatters,
    readOnly: isReadOnly,
    initialValue: initialValue,
    minLines: minLines,    
    maxLines: maxLines,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    maxLength: maxLength,
    decoration: InputDecoration(
      contentPadding: AppStyles.contentPadding,
      alignLabelWithHint: true,
      filled: true,
      fillColor: isReadOnly ? Colors.grey.shade300 : AppStyles.colorGrey4,
      isDense: true,
      labelText: mandatory ? '$labelText *' : labelText,
      hintText: mandatory? '$labelText *' : labelText,
      hintStyle: AppStyles.textStyleHint,
      labelStyle: AppStyles.inputLabelStyle,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.colorBlue2, width: 1),
      ),       
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.colorGrey4, width: 1),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.errorColor, width: 1),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.errorColor, width: 1),
      ),        
    ),
    validator: (value) {
      if (mandatory && (value?.isEmpty ?? true)) {
        return 'Поле обязательное для заполнения';
      }
      return validator?.call(value!);
    },
    onSaved: (value) => onSaved?.call(value!),
  );
}
