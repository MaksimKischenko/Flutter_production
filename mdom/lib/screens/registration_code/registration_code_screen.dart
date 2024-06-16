import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'widgets/widgets.dart';


@RoutePage()
class RegistrationCodeScreen extends StatefulWidget {
  // static const pageRoute = '/registration/code';
  static const pageRoute = '${RegistrationScreen.pageRoute}/:code';
  final ConfirmCodeType codeType;

  const RegistrationCodeScreen({required this.codeType});

  @override
  _RegistrationCodeScreenState createState() => _RegistrationCodeScreenState();
}

class _RegistrationCodeScreenState extends State<RegistrationCodeScreen> {
  final _codeFormKey = GlobalKey<FormState>();

  int? _code;

  final _nodeCode = FocusNode();

  @override
  Widget build(BuildContext context) => DismissOutside(
        child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationError) {
                RequestUtil.catchNetworkError(
                    context: context, obj: state.error);
              } else if (state is RegistrationErrorKomplat) {
                RequestUtil.catchKomplatError(
                    context: context,
                    errorCode: state.errorCode,
                    errorText: state.errorMessage);
              } else if (state is RegistrationCodeSendSuccess) {
                // TODO there after reload in web it triggers this
                SystemChannels.textInput.invokeMethod<void>('TextInput.hide');

                AutoRouter.of(context).push(const RegistrationSuccessRoute());
                // Navigation.toRegistrationSuccess();
              }
            },
            child: Scrollbar(
              child: KeyboardActions(
                config: keyboardConfig,
                disableScroll: true,
                child: Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: FullScreen(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 16),
                                Image.asset(
                                  'assets/images/main-logo.png',
                                  width: 130,
                                ),
                                const SizedBox(height: 64),
                                const Text(
                                  'Регистрация',
                                  style: TextStyle(
                                    color: AppStyles.mainTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 26,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 24, 24, 24),
                                  child: Form(
                                    key: _codeFormKey,
                                    child: CodeField(
                                      focusNode: _nodeCode,
                                      codeType: widget.codeType,
                                      onSaved: (value) {
                                        _code = value.toInt();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: RegistrationApplyButton(
                            text: 'Зарегистрироваться',
                            onPressed: _onProceedTap,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      );

  KeyboardActionsConfig get keyboardConfig =>
      AppStyles.keyboardConfig(actions: [
        KeyboardActionsItem(
            focusNode: _nodeCode,
            displayArrows: false,
            toolbarButtons: [AppStyles.doneButton]),
      ]);

  void _onProceedTap() {
    if (_codeFormKey.currentState?.validate() ?? false) {
      _codeFormKey.currentState?.save();

      context.read<RegistrationBloc>().add(RegistrationCodeSend(code: _code!));
    }
  }
}
