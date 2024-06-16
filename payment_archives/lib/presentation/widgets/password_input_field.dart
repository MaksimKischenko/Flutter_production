import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class PasswordInputField extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final bool mandatory;
  final bool isReadOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onSaved;
  final String? Function(String)? validator;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;

  
  const PasswordInputField({
    required this.labelText,
    this.initialValue,
    this.controller,
    this.isReadOnly = false,
    this.mandatory = true,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {

  bool _passwordHidden = true;

  @override
  Widget build(BuildContext context) => TextFormField(
    cursorColor: AppStyles.colorBlack,
    cursorWidth: 1,     
    autocorrect: false,  
    minLines: 1, 
    controller: widget.controller,
    readOnly: widget.isReadOnly,
    focusNode: widget.focusNode,
    obscureText:_passwordHidden,
    initialValue: widget.initialValue,
    textInputAction: TextInputAction.done,
    style: AppStyles.textStyleBlackTextFieldsContent,
    decoration: InputDecoration(
      contentPadding: AppStyles.contentPadding,
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          onTap: () => setState(() => _passwordHidden = !_passwordHidden),
          child: Icon(
            _passwordHidden ? Icons.visibility_off : Icons.visibility ,
            size: 16,  
            color: AppStyles.colorGrey2
          ),
        ),
      ),   
      suffixIconConstraints: const BoxConstraints(maxHeight: 16),     
      alignLabelWithHint: true,
      filled: true,
      fillColor: widget.isReadOnly ? Colors.grey.shade300 : AppStyles.colorGrey4,
      isDense: true,
      labelText: widget.mandatory ? '${widget.labelText} *' : widget.labelText,
      hintText: widget.mandatory ? '${widget.labelText} *' : widget.labelText,
      hintStyle: AppStyles.textStyleHint,
      labelStyle: AppStyles.inputLabelStyle,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.colorBlue2, width: 1),
      ),       
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.colorGrey4, width: 1),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.errorColor, width: 1),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: AppStyles.errorColor, width: 1),
      ), 
    ),
    validator: (value) => widget.validator?.call(value!),
    onSaved: (value) => widget.onSaved?.call(value!),
    onChanged: (value) => widget.onChanged?.call(value),
    onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
  );
}