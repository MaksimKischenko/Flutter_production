import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSaved;
  final String? Function(String)? validator;
  final String labelText;
  final String hintText;

  const PasswordField({
    required this.controller,
    this.onSaved,
    this.validator,
    required this.labelText,
    required this.hintText,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  static const minLength = 6;

  bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.visiblePassword,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
    // inputFormatters: [LngthLimitingTextInputFormatter()],
    obscureText: _obscureText,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      counterText: '',
      labelText: widget.labelText,
      hintText: widget.hintText,
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      enabledBorder: AppStyles.inputBorderUnderline,
      border: AppStyles.inputBorderUnderline,
      isDense: true,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText
              ? Icons.visibility
              : Icons.visibility_off,
          size: AppStyles.inputIconSize,
          color: AppStyles.inputIconColor,
        )
      )
    ),
    validator: (text) {
      if (text?.isEmpty ?? true) {
        return context.t.widgets.passwordField.errors.empty;
      }
      if (text!.length < minLength) {
        return context.t.widgets.passwordField.errors.minLength(
          minLength: minLength,
        );
      }
      return widget.validator?.call(text);
    },
    onSaved: (text) => widget.onSaved?.call(text!),
  );
}