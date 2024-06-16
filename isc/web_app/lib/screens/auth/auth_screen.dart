import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/config.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/utils.dart';
import 'package:isc_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';


@RoutePage()
class AuthScreen extends StatefulWidget {
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
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final _data = AuthScreenData();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: AppConfig.defaultPassword);
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
                errorText: state.errorMessage
              );
          } else if (state is AuthAuthorized) {         
             AutoRouter.of(context).push(const ClaimsRoute());
          }           
        },
        child: Scaffold(
          backgroundColor: AppStyles.backgroundColor,
          body: Center(
            child: Card(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 360,
                  maxHeight: 360
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // const SizedBox(height: 16),
                    // Center(
                    //   child: SvgPicture.asset('assets/images/logo.svg'),
                    // ),
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
                            EmailField(
                              focusNode: _emailFocus,
                              onFieldSubmitted: (_) {
                                _emailFocus.unfocus();
                                FocusScope.of(context).requestFocus(_passwordFocus);
                              },
                              onSaved: (email) {
                                _data.email = email;
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
                                _onAuthPressed();
                              },
                              onSaved: (password) {
                                _data.password = AppConfig.passwordCrypter(password);
                              },
                            ),
                            const SizedBox(height: 16),
                            AuthButton(
                              text: context.t.mobileScreens.auth.authButton,
                              onPressed: () {
                                _onAuthPressed();
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

}
