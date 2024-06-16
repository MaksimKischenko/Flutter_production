import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;
  final bool needValidate;
  final TextEditingController? controller;

  final _phoneFormatter = MaskTextInputFormatter(mask: '## ###-##-##', filter: { '#': RegExp(r'[0-9]') });

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
      labelText: 'Номер телефона',
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
          return 'Поле обязательно для заполнения';
        }
        final mask = RegExp('^(29|33|44|25)[0-9]{7,7}\$');
        if (!mask.hasMatch(_phoneFormatter.getUnmaskedText())) {
          return 'Неверный формат';
        }
      }
      return null;
    },
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (_) => onSaved?.call('375${_phoneFormatter.getUnmaskedText()}'),
  );
}