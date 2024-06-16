import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class EmailField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const EmailField({this.focusNode, this.onFieldSubmitted, this.onSaved});

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
          labelText: 'E-mail',
          hintText: '',
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelStyle,
          enabledBorder: AppStyles.inputBorder,
          border: AppStyles.inputBorder,
          isDense: true,
        ),
        validator: (email) {
          if (email?.isEmpty ?? true) {
            return null;
          }
          if (!EmailValidator.validate(email!)) {
            return context.t.widgets.emailField.errors.incorrect;
          }
          return null;
        },
        onFieldSubmitted: (email) => onFieldSubmitted?.call(email),
        onSaved: (email) => onSaved?.call(email!),
      );
}
