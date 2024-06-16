import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class PasswordTextField extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onSaved;
  final String? Function(String)? validator;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;

  
  const PasswordTextField({
    required this.labelText,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  bool _passwordHidden = true;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 300,
    child: TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autocorrect: false,  
      obscureText:_passwordHidden,
      cursorColor: AppStyles.mainColor,
      initialValue: widget.initialValue,
      textInputAction: TextInputAction.done,
      style: const TextStyle(
        color: AppStyles.mainTextColor
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
          borderRadius: BorderRadius.circular(5)
        ),
        suffixIcon: IconButton(
          splashRadius: 1,
          onPressed: () => setState(() => _passwordHidden = !_passwordHidden),
          icon: Icon(
            _passwordHidden ? Icons.visibility : Icons.visibility_off,
            size: 20,
            color: AppStyles.mainColor
          ),
        ),
        alignLabelWithHint: true,
        filled: true,
        isDense: true,
        fillColor: AppStyles.mainColor.withOpacity(0.03),
        labelText: widget.labelText,
        labelStyle: AppStyles.labelTextFieldStyle,
        hintStyle: const TextStyle(
          color: AppStyles.mainTextColor
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5)
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1)
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide:  BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
        //   borderRadius: BorderRadius.circular(5)
        // )
      ),
      validator: (value) => widget.validator?.call(value!),
      onSaved: (value) => widget.onSaved?.call(value!),
      onChanged: (value) => widget.onChanged?.call(value),
      onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
    ),
  );
}