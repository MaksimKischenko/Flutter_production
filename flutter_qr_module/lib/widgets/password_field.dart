import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PasswordField extends StatefulWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;
  final TextInputAction? textInputAction;
  final String labelText;
  final String hintText;
  final String? Function(String)? validator;
  final TextEditingController? controller;

  const PasswordField(
      {this.focusNode,
      this.onFieldSubmitted,
      this.onSaved,
      this.textInputAction,
      required this.labelText,
      required this.hintText,
      this.validator,
      this.controller});

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
        textInputAction: widget.textInputAction,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
              RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
        ],
        focusNode: widget.focusNode,
        obscureText: _obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            alignLabelWithHint: true,
            labelStyle: AppStyles.inputLabelStyle,
            enabledBorder: AppStyles.inputBorder,
            border: AppStyles.inputBorder,
            isDense: true,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  size: AppStyles.inputIconSize,
                  color: AppStyles.inputIconColor,
                ))),
        validator: (password) {
          if (password?.isEmpty ?? true) {
            return context.t.widgets.passwordField.errors.empty;
          }
          if (password!.length < minLength) {
            return context.t.widgets.passwordField.errors.minLength(
              minLength: minLength,
            );
          }
          return widget.validator?.call(password);
        },
        onFieldSubmitted: (password) => widget.onFieldSubmitted?.call(password),
        onSaved: (password) => widget.onSaved?.call(password!),
      );
}
