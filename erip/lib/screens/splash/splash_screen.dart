import 'dart:developer';

import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late DataManager _dataManager;

  @override
  void initState() {
    _dataManager = InjectionComponent.getDependency<DataManager>();
    _dataManager.safeViewVisible = true;
    _checkCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthSuccessLogin) {
        _authSuccess();
      }
    },
    builder: (context, state) {
      Widget body = Container();
      if (state is AuthInitial) {
        body = const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('Пожалуйста, подождите'),
            )
          ],
        );
      }
      if (state is AuthLoading) {
        body = const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingIndicator(),
            SizedBox(
              height: 16,
            ),
            Text('Пожалуйста, подождите')
          ],
        );
      }
      if (state is AuthError) {
        body = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: clearDataButton,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                RequestUtil.kNetworkError,
                style: TextStyle(
                  color: AppStyles.mainTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: _checkCredentials,
              child: const Text(
                'Повторить',
                style: TextStyle(
                  color: AppStyles.mainColor,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      }
      if (state is AuthErrorKomplat) {
        body = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: clearDataButton,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                state.errorMessage ?? 'Неизвестная ошибка',
                style: const TextStyle(
                  color: AppStyles.mainTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
                action: () => context.read<AuthBloc>().add(AuthLogOut()),
                buttonTitle: 'Да'
              ),
              child: const Text(
                'Разлогиниться',
                style: TextStyle(
                  color: CupertinoColors.systemRed,
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
              const Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              const Center(
                child: AppLogo(size: 130)
              ),
              const Padding(
                padding: EdgeInsets.only(top: 64),
              ),
              body
            ],
          ),
        ),
      );
    },
  );

    Future<void> _checkCredentials() async{
      if(await PreferencesHelper.getFirstLoad()) {
        await SecureStorageManager.clearAll();
        await PreferencesHelper.setFirstLoad(false);
      }
      await SecureStorageManager.getCredentials().then((data) async {       
      final login = data.item1;
      final password = data.item2;
      log('login $login password $password');
      if (login != null && password != null) {
        final correctPin = await SecureStorageManager.getPinCode();
        if (correctPin != null) {
          _checkPin(login, password, correctPin);
        } else {
          _openAuth();  
        }
      } else {
        _openAuth();
      }
    });
  }

  void _checkPin(String login, String password, String correctPin) {
    final canBiometric = _dataManager.isAvailableBiometricAuth && _dataManager.authWithBiometricsFlag;
    _dataManager.safeViewVisible = true;
    Multiplatform.showPinScreen(
      context: context,
      correctPin: correctPin,
      canBiometric: canBiometric,
      komplatBiometricType: _dataManager.komplatBiometricType,
      onSuccess: () {
        _auth(login, password);
        _dataManager.safeViewVisible = false;
      }
    );
  }

  void _auth(String login, String password) {
    BlocProvider.of<AuthBloc>(context).add(
      AuthRun(
        login: login,
        password: password,
        isFromSplash: true
      )
    );
  }

  void _openAuth() {
    _dataManager.safeViewVisible = true;
    Navigation.toAuth();
  }

  void _authSuccess() {
    _dataManager.safeViewVisible = false;
    Navigation.toHome();
  }

  Widget get clearDataButton => TextButton(
    onPressed: _clearAllData,
    child: const Text(
      'Clear all data',
      style: TextStyle(
        color: CupertinoColors.systemRed
      ),
    )
  );


  Future<void> _clearAllData() async {
    await PreferencesHelper.clearAll();
    await SecureStorageManager.clearAll();
    Navigation.toSplash();
  }

}