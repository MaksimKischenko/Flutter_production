import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class AuthLoginField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const AuthLoginField({this.focusNode, this.onFieldSubmitted, this.onSaved});

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: CoreConfig.defaultLogin,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
              RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: 'Login',
          hintText: '',
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelStyle,
          enabledBorder: AppStyles.inputBorder,
          border: AppStyles.inputBorder,
          isDense: true,
        ),
        validator: (login) {
          if (login?.isEmpty ?? true) {
            return context.t.widgets.emailField.errors.empty;
          }
          return null;
        },
        onFieldSubmitted: (login) => onFieldSubmitted?.call(login),
        onSaved: (email) => onSaved?.call(email!),
      );
}
