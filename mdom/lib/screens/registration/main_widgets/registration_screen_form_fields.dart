import 'dart:convert';

import 'package:bpc/models/models.dart';
import 'package:bpc/screens/registration/widgets/fio_field.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class RegistrationScreenFormFields extends StatefulWidget {
  final FocusNode nodeEmail;
  final FocusNode nodePassword;
  final FocusNode nodePasswordRepeat;
  final bool isSmsChecked;
  final RegistrationScreenData data;
  final GlobalKey<FormState> registrationFormKey;

  const RegistrationScreenFormFields({
    super.key,
    required this.isSmsChecked,
    required this.data,
    required this.registrationFormKey,
    required this.nodeEmail,
    required this.nodePassword,
    required this.nodePasswordRepeat,
  });

  @override
  State<RegistrationScreenFormFields> createState() =>
      _RegistrationScreenFormFieldsState();
}

class _RegistrationScreenFormFieldsState
    extends State<RegistrationScreenFormFields> {
  bool _isKeyRegistrationChecked = false;

  late TextEditingController _passwordController;
  late TextEditingController _passwordRepeatController;
  late TextEditingController _phoneController;
  late TextEditingController _keyController;

  final _nodeFio = FocusNode();
  final _nodePhone = FocusNode();
  final _nodeKey = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordRepeatController = TextEditingController();
    _phoneController = TextEditingController();
    _keyController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    _phoneController.dispose();
    _keyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.registrationFormKey,
        child: Column(
          children: [
            EmailField(
              focusNode: widget.nodeEmail,
              onFieldSubmitted: (_) {
                widget.nodeEmail.unfocus();
                FocusScope.of(context).requestFocus(_nodeFio);
              },
              onSaved: (email) {
                widget.data.email = email;
              },
            ),
            const SizedBox(height: 16),
            FioField(
              focusNode: _nodeFio,
              onFieldSubmitted: (_) {
                _nodeFio.unfocus();
                FocusScope.of(context).requestFocus(widget.nodePassword);
              },
              onSaved: (fio) {
                widget.data.fio = fio;
              },
            ),
            const SizedBox(height: 16),
            PasswordField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                focusNode: widget.nodePassword,
                onFieldSubmitted: (_) {
                  widget.nodePassword.unfocus();
                  FocusScope.of(context)
                      .requestFocus(widget.nodePasswordRepeat);
                }),
            const SizedBox(height: 16),
            PasswordField(
              controller: _passwordRepeatController,
              textInputAction: widget.isSmsChecked || _isKeyRegistrationChecked
                  ? TextInputAction.next
                  : TextInputAction.done,
              focusNode: widget.nodePasswordRepeat,
              labelText: 'Повторите пароль',
              validator: (password) {
                if (_passwordController.text != password) {
                  return 'Пароли не совпадают';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                widget.nodePasswordRepeat.unfocus();
                if (widget.isSmsChecked) {
                  FocusScope.of(context).requestFocus(_nodePhone);
                }
                if (_isKeyRegistrationChecked) {
                  FocusScope.of(context).requestFocus(_nodeKey);
                }
              },
              onSaved: (password) {
                widget.data.password =
                    sha256.convert(utf8.encode(password)).toString();
              },
            ),
            const SizedBox(height: 16),
            // FeatureSwitch(
            //   value: widget.isSmsChecked,
            //   text: "Отправить код подтверждения по SMS",
            //   onChanged: (value) {
            //     setState(() {
            //       widget.isSmsChecked = value;
            //     });
            //   },
            // ),
            // SizedBox(height: 8),
            if (widget.isSmsChecked)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: PhoneField(
                  controller: _phoneController,
                  focusNode: _nodePhone,
                  needValidate: widget.isSmsChecked,
                  onFieldSubmitted: (_) {
                    _nodePhone.unfocus();
                  },
                  onSaved: (phone) {
                    widget.data.phone = phone;
                  },
                ),
              ),
            FeatureSwitch(
              value: _isKeyRegistrationChecked,
              text: 'У меня есть код регистрации',
              onChanged: (value) {
                setState(() {
                  _isKeyRegistrationChecked = value;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_isKeyRegistrationChecked)
              KeyField(
                controller: _keyController,
                focusNode: _nodeKey,
                needValidate: _isKeyRegistrationChecked,
                onFieldSubmitted: (_) {
                  _nodeKey.unfocus();
                },
                onSaved: (key) {
                  widget.data.keyRegistration = key;
                },
              ),
            if (!_isKeyRegistrationChecked) const SizedBox(height: 51),
          ],
        ),
      );
}
