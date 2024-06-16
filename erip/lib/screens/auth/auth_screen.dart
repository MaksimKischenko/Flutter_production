import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/config.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authFormKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController(text: AppConfig.defaultPassword);

  final FocusNode _nodeEmail = FocusNode();  
  final FocusNode _nodePassword = FocusNode();

  late String _email;
  late String _password;

  bool _isAuthSaveChecked = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DismissOutside(
    child: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          RequestUtil.catchError(
            context,
            state.error
          );
        }
        if (state is AuthErrorKomplat) {
          RequestUtil.catchKomplatError(
            context: context,
            errorCode: state.errorCode,
            errorText: state.errorMessage
          );
        }
        if (state is AuthAskForBiometrics) {
          _onAuthAskForBiometrics(state.biometricDescription);
        }
        if (state is AuthSuccessLogin) {
          _onAuthSuccessLogin();
        }
        if (state is AuthPinSetup) {
          _onAuthPinSetup();
        }
      },
      child: _newBody,
      // child: Scaffold(
      //   body: KeyboardActions(
      //     config: _buildConfig(context),
      //     disableScroll: true,
      //     child: FullScreen(
      //       bottomSafe: false,
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 12),
      //         child: Form(
      //           key: _authFormKey,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               HeaderLogo(),
      //               const SizedBox(height: 30),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 12),
      //                 child: EmailField(
      //                   focusNode: _nodeEmail,
      //                   onFieldSubmitted: (_) {
      //                     _nodeEmail.unfocus();
      //                     FocusScope.of(context).requestFocus(_nodePassword);
      //                   },
      //                   onSaved: (email) {
      //                     _email = email;
      //                   },
      //                 ),
      //               ),
      //               const SizedBox(height: 16),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 12),
      //                 child: PasswordField(
      //                   controller: _passwordController,
      //                   textInputAction: TextInputAction.done,
      //                   focusNode: _nodePassword,
      //                   onFieldSubmitted: (_) {
      //                     _nodePassword.unfocus();
      //                   },
      //                   onSaved: (password) {
      //                     _password = password.toSha256();
      //                   },
      //                 ),
      //               ),
      //               const SizedBox(height: 16),
      //               SaveCheckBox(
      //                 value: _isAuthSaveChecked,
      //                 onTap: (value) {
      //                   setState(() {
      //                     _isAuthSaveChecked = value;
      //                   });
      //                 },
      //               ),
      //               const SizedBox(height: 16),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 12),
      //                 child: AuthButton(
      //                   text: 'Войти',
      //                   onPressed: () {
      //                     _onAuthPressed();
      //                   },
      //                 ),
      //               ),
      //               const SizedBox(height: 16),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    ),
  );

  double get _formHeight {
    final height = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).viewPadding;
    final heightWitoutSafeArea = height - padding.top;
    return heightWitoutSafeArea;
  }

  Widget get _newBody => Scaffold(
    body: KeyboardActions(
      config: _buildConfig(context),
      // disableScroll: true,
      child: SafeArea(
        bottom: false,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: _formHeight,
              child: Column(
                children: [
                  const Spacer(),
                  // logo
                  const SizedBox(height: 16),
                  const AppLogo(size: 180),
                  const SizedBox(height: 16),
                  const Spacer(),
                  // form
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Form(
                      key: _authFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: EmailField(
                              focusNode: _nodeEmail,
                              onFieldSubmitted: (_) {
                                _nodeEmail.unfocus();
                                FocusScope.of(context).requestFocus(_nodePassword);
                              },
                              onSaved: (email) {
                                _email = email;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: PasswordField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.done,
                              focusNode: _nodePassword,
                              onFieldSubmitted: (_) {
                                _nodePassword.unfocus();
                              },
                              onSaved: (password) {
                                _password = password.toSha256();
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          SaveCheckBox(
                            value: _isAuthSaveChecked,
                            onTap: (value) {
                              setState(() {
                                _isAuthSaveChecked = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: AuthButton(
                              text: 'Войти',
                              onPressed: () {
                                _onAuthPressed();
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // company title
                  Text(
                    'ОАО «НКФО «ЕРИП»',
                    style: TextStyle(
                      color: AppStyles.mainTextColor.withOpacity(.5),
                      fontSize: 12
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 8)
                ],
              ),
            ),
          ),
        )
      ),
    ),
  );

  KeyboardActionsConfig _buildConfig(BuildContext context) => AppStyles.keyboardConfig(
    context,
    actions: [
      KeyboardActionsItem(
        focusNode: _nodeEmail,
        displayDoneButton: false,
        displayActionBar: false
      ),
      KeyboardActionsItem(
        focusNode: _nodePassword,
        displayDoneButton: false,
        displayActionBar: false
      )
    ]
  );

  void _onAuthPressed() {
    if (_authFormKey.currentState?.validate() ?? false) {
      _authFormKey.currentState!.save();

      BlocProvider.of<AuthBloc>(context).add(
        AuthRun(
          login: _email,
          password: _password,
          isAuthSaveChecked: _isAuthSaveChecked
        )
      );
    }
  }

  void _onAuthAskForBiometrics(String biometricDescription) {
    Multiplatform.showDecisionMessage(
      context: context,
      message: null,
      action: () => context.read<AuthBloc>().add(const AuthBiometricResponse(true)),
      dialogTitle: 'Использовать $biometricDescription для входа в приложение?',
      buttonTitle: 'Да',
      cancelButtonTitle: 'Нет',
      cancelAction: () => context.read<AuthBloc>().add(const AuthBiometricResponse(false)),
      dangetType: DecisionType.neutral,
      barrierDismissible: false
    );
  }

  void _onAuthSuccessLogin() {
    Navigation.toHome();
  }

  void _onAuthPinSetup() {
    Multiplatform.showVerifyPinScreen(
      context: context,
      title: 'Придумайте PIN',
      onSuccess: (String pin) => context.read<AuthBloc>().add(AuthSetPin(pin))
    );
  }
}