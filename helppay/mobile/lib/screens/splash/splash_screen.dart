
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/injection_component.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'splash_screen');

class SplashScreen extends StatefulWidget {
  static const pageRoute = '/';

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DataManager _dataManager;

  _SplashScreenState()
      : _dataManager = InjectionComponent.getDependency<DataManager>();

  @override
  void initState() {
    _dataManager.safeViewVisible = true;
    _checkCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _authSuccess();
          }
        },
        builder: (context, state) {
          Widget body = Container();
          if (state is AuthInitial) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(context.t.mobileScreens.splash.loadingMessage)
              ],
            );
          }
          if (state is AuthLoading) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MultiplatformIndicator(),
                const SizedBox(height: 16),
                Text(context.t.mobileScreens.splash.loadingMessage)
              ],
            );
          }
          if (state is AuthError) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  RequestUtil.networkError,
                  style: const TextStyle(
                      color: AppStyles.mainColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _checkCredentials,
                  child: Text(
                    context.t.mobileScreens.splash.repeatButton,
                    style: const TextStyle(
                      color: AppStyles.mainColor,
                    ),
                  ),
                )
              ],
            );
          }
          if (state is AuthErrorKomplat) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  state.errorMessage ??
                      context.t.mobileScreens.splash.errorMessage,
                  style: const TextStyle(
                      color: AppStyles.mainColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _checkCredentials,
                  child: Text(
                    context.t.mobileScreens.splash.repeatButton,
                    style: const TextStyle(
                      color: AppStyles.mainColor,
                    ),
                  ),
                )
              ],
            );
          }
          return Scaffold(
            body: FullScreen(
              bottomSafe: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Center(child: SvgPicture.asset('assets/images/logo.svg')),
                  const SizedBox(height: 64),
                  body
                ],
              ),
            ),
          );
        },
      );

  // ignore: avoid_void_async
  void _checkCredentials() async {
    if (await SecureStorageManager.read(SecureStorageKeys.furstLoad) ?? true) {
      await SecureStorageManager.storage.deleteAll();
      await SecureStorageManager.write(SecureStorageKeys.furstLoad, false);
    }
    final login = await SecureStorageManager.read(SecureStorageKeys.login);
    final password =
        await SecureStorageManager.read(SecureStorageKeys.password);

    if (login != null && password != null) {
      final correctPin =
          await SecureStorageManager.read(SecureStorageKeys.pincode);
      // String correctPin = "1234";
      if (correctPin != null) {
        _log('current pin - $correctPin');
        _checkPin(login, password, correctPin);
      } else {
        _openAuth();
      }
    } else {
      _openAuth();
    }
  }

  void _checkPin(String login, String password, String correctPin) {
    final canBiometric = _dataManager.isAvailableBiometricAuth &&
        _dataManager.authWithBiometricsFlag;
    _dataManager.safeViewVisible = true;
    Multiplatform.showPinScreen(
        context: context,
        correctPin: correctPin,
        title: t.modal.pinVerify.title,
        footerTitle: t.modal.pinVerify.forgetPinButton,
        canBiometric: canBiometric,
        komplatBiometricType: _dataManager.komplatBiometricType,
        cancelButtonTitle: '',
        biometricReason: t.modal.pinVerify.biometricReason,
        onSuccess: () {
          _auth(login, password);
          _dataManager.safeViewVisible = false;
        });
  }

  void _auth(String login, String password) {
    final data = AuthScreenData(login: login, password: password);
    context.read<AuthBloc>().add(AuthRun(data: data));
  }

  void _openAuth() {
    _dataManager.safeViewVisible = true;
    Navigation.toAuth();
  }

  void _authSuccess() {
    _dataManager.safeViewVisible = false;
    if (CoreConfig.appFlavour == AppFlavour.full ||
        CoreConfig.appFlavour == AppFlavour.helppay) {
      // to main
      Navigation.toMain();
    } else {
      // open accruals as main
      Navigation.toMdomAccruals();
    }
  }
}
