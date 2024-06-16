import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class LoginField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const LoginField({this.focusNode, this.onFieldSubmitted, this.onSaved});

  @override
  Widget build(BuildContext context) => TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
            RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'),
          )
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: context.t.mobileScreens.authPasswordReset.login,
          hintText: context.t.mobileScreens.authPasswordReset.loginHint,
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelStyle,
          enabledBorder: AppStyles.inputBorder,
          border: AppStyles.inputBorder,
          isDense: true,
        ),
        validator: (login) {
          if (login?.isEmpty ?? true) {
            return context.t.mobileScreens.authPasswordReset.errors.empty;
          }
          return null;
        },
        onFieldSubmitted: (login) => onFieldSubmitted?.call(login),
        onSaved: (login) => onSaved?.call(login!),
      );
}
