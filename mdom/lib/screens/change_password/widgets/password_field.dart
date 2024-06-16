import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSaved;
  final String? Function(String)? validator;
  final String labelText;
  final String hintText;
  final FocusNode? focusNode;

  const PasswordField({
    required this.controller,
    this.onSaved,
    this.validator,
    required this.labelText,
    required this.hintText,
    this.focusNode
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  static const minLength = 6;

  bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: widget.focusNode,
    controller: widget.controller,
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
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'Введите пароль';
      }
      if (value!.length < minLength) {
        return 'Минимальная длина пароля 6 символов';
      }
      return widget.validator?.call(value);
    },
    onSaved: (value) => widget.onSaved?.call(value!),
  );
}