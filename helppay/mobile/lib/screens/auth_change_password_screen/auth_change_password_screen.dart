import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/auth_password_reset/auth_reset_password_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/auth_change_password_screen/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

class AuthChangePasswordScreen extends StatefulWidget {
  static const pageRoute = '/auth_change_password';

  const AuthChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AuthChangePasswordScreenState createState() =>
      _AuthChangePasswordScreenState();
}

class _AuthChangePasswordScreenState extends State<AuthChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // late TextEditingController _passwordController;
  final FocusNode _loginFocus = FocusNode();

  final FocusNode _emailFocus = FocusNode();

  final _data = AuthScreenResetData();

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthResetPasswordBloc, AuthResetPasswordState>(
        listener: (context, state) {
          if (state is AuthResetError) {
            Multiplatform.showMessage(
              context: context,
              title: t.general.errorModal.title,
              message: state.error.toString(),
              type: DialogType.error,
            );
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is AuthResetErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          }
          if (state is AuthResetSuccess) {
            _authResetSuccess();
            Multiplatform.showMessage(
              context: context,
              title: t.mobileScreens.authPasswordReset.success,
              message: t.mobileScreens.authPasswordReset.message,
              type: DialogType.success,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: FullScreen(
            bottomSafe: false,
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
                    context.t.mobileScreens.authPasswordReset.title,
                    style: AppStyles.headerTextStyle,
                  ),
                ),
                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        LoginField(
                          focusNode: _loginFocus,
                          onFieldSubmitted: (_) {
                            _loginFocus.unfocus();
                          },
                          onSaved: (login) {
                            _data.login = login;
                          },
                        ),

                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              t.mobileScreens.authPasswordReset
                                  .communicationSource,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        EmailField(
                          focusNode: _emailFocus,
                          onFieldSubmitted: (_) {
                            _emailFocus.unfocus();
                            FocusScope.of(context).requestFocus(_loginFocus);
                          },
                          onSaved: (email) {
                            _data.email = email;
                          },
                        ),
                        const SizedBox(height: 16),
                        AuthResetPhoneField(
                          onSaved: (phone) {
                            _data.phone = '375$phone';
                          },
                        ),
                        // LoginField(
                        //   focusNode: _loginFocus,
                        //   onFieldSubmitted: (_) {
                        //     _loginFocus.unfocus();
                        //   },
                        //   onSaved: (login) {
                        //     _data.login = login;
                        //   },
                        // ),
                        const SizedBox(height: 16),
                        MaterialButton(
                            onPressed: _onAuthPressed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            highlightElevation: 0,
                            minWidth: double.maxFinite,
                            color: AppStyles.mainColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              context.t.mobileScreens.authPasswordReset
                                  .resetButton,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            )),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _onAuthPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      context.read<AuthResetPasswordBloc>().add(AuthResetPassword(data: _data));
    }
  }

  void _authResetSuccess() {
    Navigation.navigatorKey.currentState?.pop();
  }
}
