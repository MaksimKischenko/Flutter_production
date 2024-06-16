import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  static const pageRoute = '/';

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late DataManager _dataManager;

  @override
  void initState() {
    super.initState();
    _dataManager = InjectionComponent.getDependency<DataManager>();
    _dataManager.safeViewVisible = true;
    _checkCredentials();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<AuthMdomBloc, AuthMdomState>(
        listener: (context, state) {
          if (state is AuthMdomSuccessLogin) {
            _authSuccess();
          }
        },
        builder: (context, state) {
          Widget body = Container();
          if (state is AuthMdomInitial) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 8),
                Text('Пожалуйста, подождите')
              ],
            );
          } else if (state is AuthMdomLoading) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                LoadingIndicator(),
                SizedBox(height: 16),
                Text('Пожалуйста, подождите')
              ],
            );
          } else if (state is AuthMdomError) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  RequestUtil.kNetworkError,
                  style: TextStyle(
                    color: AppStyles.mainTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _checkCredentials,
                  child: const Text(
                    'Повторить',
                    style: TextStyle(
                      color: AppStyles.mainColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Multiplatform.showDecisionMessage(
                      context: context,
                      message: 'Уверены, что хотите разлогиниться?',
                      action: () {
                        context.read<AuthMdomBloc>().add(AuthMdomLogOut());
                      },
                      buttonTitle: 'Да'),
                  child: const Text(
                    'Разлогиниться',
                    style: TextStyle(
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is AuthMdomErrorKomplat) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.errorMessage ?? 'Неизвестная ошибка',
                  style: const TextStyle(
                      color: AppStyles.mainTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _checkCredentials,
                  child: const Text(
                    'Повторить',
                    style: TextStyle(
                      color: AppStyles.mainColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Multiplatform.showDecisionMessage(
                      context: context,
                      message: 'Уверены, что хотите разлогиниться?',
                      action: () {
                        context.read<AuthMdomBloc>().add(AuthMdomLogOut());
                        unawaited(
                          AutoRouter.of(context).push(const SplashRoute()),
                        );
                      },
                      buttonTitle: 'Да'),
                  child: const Text(
                    'Разлогиниться',
                    style: TextStyle(
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
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
                  const Center(
                    child: AppLogo(),
                  ),
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
    final login = await SecureStorageManager.read(SecureStorageKeys.login);
    final password =
        await SecureStorageManager.read(SecureStorageKeys.password);

    if (login != null && password != null) {
      final correctPin =
          await SecureStorageManager.read(SecureStorageKeys.pincode);
      // String correctPin = "1234";
      if (correctPin != null) {
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
        canBiometric: canBiometric,
        komplatBiometricType: _dataManager.komplatBiometricType,
        onSuccess: () {
          _auth(login, password);
          _dataManager.safeViewVisible = false;
        });
  }

  void _auth(String login, String password) {
    context
        .read<AuthMdomBloc>()
        .add(AuthMdomRun(email: login, password: password, isFromSplash: true));
  }

  void _openAuth() {
    _dataManager.safeViewVisible = true;
    AutoRouter.of(context).push(const AuthRoute());

    // AutoRouter.of(context).push(const AuthRoute());();
  }

  void _authSuccess() {
    _dataManager.safeViewVisible = false;
    // Navigation.toHome();
    AutoRouter.of(context)
        .push(kIsWeb ? const PollsListRoute() : const MainRouteMobile());

    // Navigation.toMain();
  }
}
