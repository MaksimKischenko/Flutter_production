import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/fio_fild.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  static const pageRoute = '/registration';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registrationFormKey = GlobalKey<FormState>();

  bool _isSmsChecked = false;

  late TextEditingController _passwordController;
  late TextEditingController _passwordRepeatController;
  late TextEditingController _phoneController;

  final FocusNode _loginFocus = FocusNode();
  final FocusNode _fioFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordRepeatFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final _data = RegistrationScreenData();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: '123456');
    _passwordRepeatController = TextEditingController(text: '123456');
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<RegistrationBloc,
          RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationError) {
          RequestUtil.catchNetworkError(context: context, obj: state.error);
        }
        if (state is RegistrationErrorKomplat) {
          RequestUtil.catchKomplatError(
              context: context,
              errorCode: state.errorCode,
              errorText: state.errorMessage);
        }
        if (state is RegistrationSuccess) {
          _registrationSuccess(
            context: context,
            params: state.params,
            lookups: state.lookups,
            codeType: state.codeType,
            phoneNumber: state.phoneNumber,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360, maxHeight: 700),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    SvgPicture.asset('assets/images/logo.svg'),
                    const SizedBox(height: 64),
                    Text(
                      context.t.mobileScreens.registration.title,
                      style: AppStyles.headerTextStyle,
                    ),
                    const SizedBox(height: 36),
                    Form(
                      key: _registrationFormKey,
                      child: Column(
                        children: [
                          AuthLoginField(
                            focusNode: _loginFocus,
                            onFieldSubmitted: (_) {
                              _loginFocus.unfocus();
                              FocusScope.of(context).requestFocus(_fioFocus);
                            },
                            onSaved: (login) {
                              _data.login = login;
                            },
                          ),
                          const SizedBox(height: 16),
                          FioField(
                            focusNode: _fioFocus,
                            onFieldSubmitted: (_) {
                              _fioFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            },
                            onSaved: (fio) {
                              _data.fio = fio;
                            },
                          ),
                          const SizedBox(height: 16),
                          PasswordField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.next,
                              labelText: context.t.widgets.passwordField.title,
                              hintText: '',
                              focusNode: _passwordFocus,
                              onFieldSubmitted: (_) {
                                _passwordFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_passwordRepeatFocus);
                              }),
                          const SizedBox(height: 16),
                          PasswordField(
                            controller: _passwordRepeatController,
                            textInputAction: _isSmsChecked
                                ? TextInputAction.next
                                : TextInputAction.done,
                            focusNode: _passwordRepeatFocus,
                            labelText: context.t.mobileScreens.registration
                                .passwordRepeatField.title,
                            hintText: '',
                            validator: (password) {
                              if (_passwordController.text != password) {
                                return context
                                    .t
                                    .mobileScreens
                                    .registration
                                    .passwordRepeatField
                                    .errors
                                    .passwordsNotMatch;
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _passwordRepeatFocus.unfocus();
                              if (_isSmsChecked) {
                                FocusScope.of(context)
                                    .requestFocus(_phoneFocus);
                              }
                            },
                            onSaved: (password) {
                              _data.password = sha256
                                  .convert(utf8.encode(password))
                                  .toString();
                            },
                          ),
                          const SizedBox(height: 16),
                          SmsSwitch(
                            value: _isSmsChecked,
                            onChanged: (value) {
                              setState(() {
                                _isSmsChecked = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          if (_isSmsChecked)
                            PhoneField(
                              controller: _phoneController,
                              focusNode: _phoneFocus,
                              needValidate: _isSmsChecked,
                              onFieldSubmitted: (_) {
                                _phoneFocus.unfocus();
                              },
                              onSaved: (phone) {
                                _data.phone = phone;
                              },
                            )
                          else
                            const SizedBox(height: 51)
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    RegistrationApplyButton(
                      text: context.t.mobileScreens.registration.applyButton,
                      onPressed: () => _onProceedTap(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));

  void _onProceedTap(BuildContext context) {
    if (_registrationFormKey.currentState?.validate() ?? false) {
      _registrationFormKey.currentState?.save();
      _data.isSendCodeSMS = _isSmsChecked;
      context.read<RegistrationBloc>().add(RegistrationRun(data: _data));
    }
  }

  void _registrationSuccess({
    required BuildContext context,
    required List<MdomResponseParam>? params,
    required ConfirmCodeType codeType,
    required List<MdomLookupItem>? lookups,
    required String? phoneNumber,
  }) {
    if ((params ?? []).isEmpty) {
      AutoRouter.of(context).push(
        RegistrationCodeRoute(codeType: codeType),
      );
    } else {
      AutoRouter.of(context).pushAndPopUntil(
          RegistrationParamsRoute(
            params: params!.where((e) => (e.view ?? 0) == 1).toList(),
            lookups: lookups,
            phoneNumber: phoneNumber,
          ),
          predicate: (route) => false);
    }
  }
}
