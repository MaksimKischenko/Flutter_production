import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onSaved;
  final bool needValidate;
  final TextEditingController? controller;

  final _phoneFormatter = MaskTextInputFormatter(mask: '## ###-##-##', filter: { '#': RegExp('[0-9]') });

  PhoneField({
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved,
    required this.needValidate,
    this.controller
  });

  @override
  Widget build(BuildContext context) => TextFormField(
      controller: controller,
      inputFormatters: [_phoneFormatter],
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixText: '+375 ',
        labelText: context.t.mobileScreens.registration.phoneField.title,
        hintText: '## ###-##-##',
        alignLabelWithHint: true,
        labelStyle: AppStyles.inputLabelStyle,
        enabledBorder: AppStyles.inputBorder,
        border: AppStyles.inputBorder,
        isDense: true,
      ),
      validator: (phone) {
        if (needValidate) {
          if (phone?.isEmpty ?? true) {
            return context.t.mobileScreens.registration.phoneField.errors.empty;
          }
          final mask = RegExp(r'^(29|33|44|25)[0-9]{7,7}$');
          if (!mask.hasMatch(_phoneFormatter.getUnmaskedText())) {
            return context.t.mobileScreens.registration.phoneField.errors.incorrectFormat;
          }
        }
        return null;
      },
      onFieldSubmitted: (phone) => onFieldSubmitted?.call(phone),
      onSaved: (_) => onSaved?.call('375${_phoneFormatter.getUnmaskedText()}'),
    );
}