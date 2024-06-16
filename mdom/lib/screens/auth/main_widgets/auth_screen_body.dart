import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/config.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../widgets/widgets.dart';

class AuthScreenBody extends StatefulWidget {
  const AuthScreenBody({super.key});

  @override
  State<AuthScreenBody> createState() => _AuthScreenBodyState();
}

class _AuthScreenBodyState extends State<AuthScreenBody> {
  final _authFormKey = GlobalKey<FormState>();
  final _nodeEmail = FocusNode();
  final _nodePassword = FocusNode();
  late TextEditingController _passwordController;

  late String _email;
  late String _password;

  bool _isAuthSaveChecked = false;
  @override
  void initState() {
    super.initState();
    _passwordController =
        TextEditingController(text: AppConfig.defaultPassword);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardActions(
        config: AppStyles.keyboardConfig(
          actions: [
            KeyboardActionsItem(
              focusNode: _nodeEmail,
              displayDoneButton: false,
              displayActionBar: false,
            ),
            KeyboardActionsItem(
              focusNode: _nodePassword,
              displayDoneButton: false,
              displayActionBar: false,
            )
          ],
        ),
        disableScroll: true,
        child: FullScreen(
          maxWidthConstraint: 500,
          bottomSafe: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: AppLogo(),
              ),
              const SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  key: _authFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            _password = AppConfig.passwordCrypter(password);
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
                          onPressed: _onAuthPressed,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ApplyButtonSecondary(
                          text: 'Зарегистрироваться',
                          onPressed: _onRegistrationTap,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _onAuthPressed() {
    if (_authFormKey.currentState?.validate() ?? false) {
      _authFormKey.currentState?.save();

      context.read<AuthMdomBloc>().add(
            AuthMdomRun(
              email: _email,
              password: _password,
              isAuthSaveChecked: _isAuthSaveChecked,
            ),
          );
    }
  }

  void _onRegistrationTap() {
    AutoRouter.of(context).push(const RegistrationRoute());

    // Navigation.toRegistration();
  }
}
