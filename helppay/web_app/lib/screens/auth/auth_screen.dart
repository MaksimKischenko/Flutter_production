import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/auth');

  static const pageRoute = '/auth';
  final String? next;

  const AuthScreen({
    this.next,
    Key? key,
  }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authFormKey = GlobalKey<FormState>();

  late TextEditingController _passwordController;
  final FocusNode _loginFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final _data = AuthScreenData();

  @override
  void initState() {
    super.initState();
    _passwordController =
        TextEditingController(text: CoreConfig.defaultPassword);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is AuthErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          } else if (state is AuthAuthorized) {
            AutoRouter.of(context).push(const MdomAccrualsRoute());
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 360, maxHeight: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: SvgPicture.asset('assets/images/logo.svg'),
                    ),
                    const SizedBox(height: 64),
                    Center(
                      child: Text(
                        context.t.mobileScreens.auth.title,
                        style: AppStyles.headerTextStyle,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Form(
                        key: _authFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AuthLoginField(
                              focusNode: _loginFocus,
                              onFieldSubmitted: (_) {
                                _loginFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                              onSaved: (login) {
                                _data.login = login;
                              },
                            ),
                            const SizedBox(height: 16),
                            PasswordField(
                              controller: _passwordController,
                              textInputAction: TextInputAction.done,
                              labelText: context.t.widgets.passwordField.title,
                              hintText: '',
                              focusNode: _passwordFocus,
                              onFieldSubmitted: (_) {
                                _passwordFocus.unfocus();
                              },
                              onSaved: (password) {
                                _data.password =
                                    CoreConfig.passwordCrypter(password);
                              },
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: NoSplashButton(
                                text:
                                    context.t.mobileScreens.auth.forgotPassword,
                                withAddIcon: false,
                                onTap: () => AutoRouter.of(context)
                                    .push(const AuthChangePasswordRoute()),
                              ),
                            ),
                            const SizedBox(height: 16),
                            AuthButton(
                              text: context.t.mobileScreens.auth.authButton,
                              onPressed: () {
                                _onAuthPressed();
                              },
                            ),
                            const SizedBox(height: 16),
                            ApplyButtonSecondary(
                              text: context
                                  .t.mobileScreens.auth.registrationButton,
                              onPressed: () {
                                _openRegistration();
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _onAuthPressed() {
    if (_authFormKey.currentState?.validate() ?? false) {
      _authFormKey.currentState?.save();
      context.read<AuthBloc>().add(AuthRun(
            data: _data,
          ));
    }
  }

  void _openRegistration() {
    AutoRouter.of(context).push(const RegistrationRoute());
  }
}
