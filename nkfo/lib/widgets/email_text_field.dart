import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:web_cabinet_nkfo/styles.dart';

class EmailTextField extends StatelessWidget {
  final Key? key;
  final GlobalKey<FormFieldState>? fieldKey;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool mandatory;
  final Function(String?)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;

  const EmailTextField({
    this.key,
    this.fieldKey,
    this.focusNode,
    this.controller,
    this.mandatory = true,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    key: fieldKey,
    autocorrect: false,
    cursorColor: AppStyles.mainColor,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
    focusNode: focusNode,
    onChanged: onChanged,
    maxLength: 255,
    decoration: InputDecoration(
      labelText: mandatory? 'E-mail *' :'E-mail',
      hintText: '',
      alignLabelWithHint: true,
      filled: true,
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
        borderRadius: BorderRadius.circular(5)
      ),
      fillColor: AppStyles.mainColor.withOpacity(0.03),
      labelStyle: AppStyles.labelTextFieldStyle,
      hintStyle: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      ),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1)
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderSide:  BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
      //   borderRadius: BorderRadius.circular(10)
      // )
    ),
    validator: (value) {
      if(mandatory) {
        if (value?.isEmpty ?? true) {
          return 'Введите E-mail';
        }
        if (!EmailValidator.validate(value!)) {
          return 'Неверный формат E-mail';
        }
        return null;
      }
      return null;
    },
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (value) => onSaved?.call(value),
  );
}