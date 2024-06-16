import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isc_web_app/styles.dart';

class AccNumField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const AccNumField({
    this.controller,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    controller: controller,
    keyboardType: TextInputType.text,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
    autocorrect: false,
    decoration: InputDecoration(
      labelText: 'Номер счета',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      enabledBorder: AppStyles.inputBorderOutline,
      border: AppStyles.inputBorderOutline,
      errorBorder: AppStyles.errorWebBorder,
      focusedErrorBorder: AppStyles.errorWebBorder,
      isDense: true      
    ),
    validator: (value) => null,
  );
}