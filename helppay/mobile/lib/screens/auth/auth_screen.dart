import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  static const pageRoute = '/auth';

  const AuthScreen({
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
          }
          if (state is AuthErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          }
          if (state is AuthSuccess) {
            _authSuccess();
          }
          if (state is AuthPinSetSuccess) {
            _authPinSetSuccess(
              askForBimetrics: state.askForBimetrics,
              komplatBiometricType: state.komplatBiometricType,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              LanguagePicker(
                currentLocale: TranslationProvider.of(context).locale,
                onChanged: _onLanguageChanged,
              ),
              // const SizedBox(width: 8),
            ],
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
                            FocusScope.of(context).requestFocus(_passwordFocus);
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
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: Navigation.toAuthChangePasswordScreen,
                          child: Text(
                            context.t.mobileScreens.auth.forgotPassword,
                            style: TextStyle(
                              color: AppStyles.mainColorDark.withOpacity(0.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        AuthButton(
                          text: context.t.mobileScreens.auth.authButton,
                          onPressed: () {
                            _onAuthPressed();
                          },
                        ),
                        const SizedBox(height: 16),
                        ApplyButtonSecondary(
                          text: context.t.mobileScreens.auth.registrationButton,
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
      );

  void _onAuthPressed() {
    // _authSuccess();
    if (_authFormKey.currentState?.validate() ?? false) {
      _authFormKey.currentState?.save();

      context.read<AuthBloc>().add(AuthRun(data: _data));
      // context.read<QrRequestBloc>().add(GetSecretKeyRequestRun());
    }
  }

  void _authSuccess() {
    Multiplatform.showVerifyPinScreen(
        context: context,
        title: t.modal.pinSetup.title.first,
        confirmTitle: t.modal.pinSetup.title.repeat,
        cancelButtonTitle: t.modal.pinSetup.cancelButton,
        footerTitle: t.modal.pinVerify.forgetPinButton,
        onSuccess: (String pin) {
          context.read<AuthBloc>().add(AuthSetPin(pin: pin));
        });
  }

  void _authPinSetSuccess(
      {required bool askForBimetrics,
      required KomplatBiometricType? komplatBiometricType}) {
    if (CoreConfig.appFlavour == AppFlavour.full ||
        CoreConfig.appFlavour == AppFlavour.helppay) {
      // to main
      Navigation.toMain();
    } else {
      // open accruals as main
      Navigation.toMdomAccruals();
    }
    if (askForBimetrics) {
      Multiplatform.showBiometricUseDialog(
        context: Navigation.navigatorKey.currentState!.overlay!.context,
        komplatBiometricType: komplatBiometricType!,
        buttonTitle: t.modal.biometricSetup.confirmButton,
        cancelButtonTitle: t.modal.biometricSetup.cancelButton,
      );
    }
  }

  void _openRegistration() {
    Navigation.toRegistration();
  }

  // void _openRegistration() {
  //   Navigation.toRegistration();
  // }

  Future<void> _onLanguageChanged(AppLocale newLang) async {
    LocaleSettings.setLocale(newLang);
    await PreferencesHelper.write(PrefsKeys.language, newLang.languageTag);
  }
}
