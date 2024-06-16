import 'package:bpc/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const EmailField({
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: 'E-mail',
      hintText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'Введите E-mail';
      }
      if (!EmailValidator.validate(value!)) {
        return 'Неверный формат E-mail';
      }
      return null;
    },
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (value) => onSaved?.call(value!),
  );
}