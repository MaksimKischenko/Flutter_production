import 'package:flutter/material.dart';
import 'package:isc_web_app/config.dart';
import 'package:isc_web_app/styles.dart';

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
    initialValue: AppConfig.defaultLogin,
    autocorrect: false,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: 'Логин',
      hintText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (email) {
      if (email?.isEmpty ?? true) {
        return 'Введите логин';
      }
      return null;
    },
    onFieldSubmitted: (email) => onFieldSubmitted?.call(email),
    onSaved: (email) => onSaved?.call(email!),
  );
}