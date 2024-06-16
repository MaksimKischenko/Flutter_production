import 'package:flutter/material.dart';

import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class AuthResetPhoneField extends StatefulWidget {
  final Function(String value) onSaved;
  const AuthResetPhoneField({super.key, required this.onSaved});

  @override
  State<AuthResetPhoneField> createState() => _AuthResetPhoneFieldState();
}

class _AuthResetPhoneFieldState extends State<AuthResetPhoneField> {
  @override
  Widget build(BuildContext context) => TextFormField(
        maxLength: 12,
        initialValue: '',
        autocorrect: false,
        // readOnly: !editable,
        keyboardType: TextInputType.phone,
        inputFormatters: ParamType.str.inputFormatters,
        // inputFormatters: [LngthLimitingTextInputFormatter()],
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixText: '+375',
          counterText: '',
          labelText: t.mobileScreens.authPasswordReset.phoneNumber,
          hintText: '## ###-##-##',
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelUnderlineStyle,
          enabledBorder: AppStyles.inputBorder,
          border: AppStyles.inputBorder,
          isDense: true,
        ),
        onSaved: (phone) => widget.onSaved(phone!),
      );
}
