import 'package:bpc_nkfo/config.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onSaved;

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
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
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
      if (email == null || email.isEmpty) {
        return 'Введите логин';
      }
      return null;
    },
    onFieldSubmitted: (email) => onFieldSubmitted?.call(email),
    onSaved: (email) => onSaved?.call(email!),
  );
}