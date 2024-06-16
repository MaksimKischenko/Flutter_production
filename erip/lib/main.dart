import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/screens/screens.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/utils/app_state_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/blocs.dart';
import 'data/data.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  InjectionComponent.run();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
      ),
      BlocProvider<QrCamBloc>(
        create: (context) => QrCamBloc()
            ..add(QrCamPermissionCheck()),
      ),
    ],
    child: BpcApp(),
  ));
}

class BpcApp extends StatefulWidget {
  @override
  _BpcAppState createState() => _BpcAppState();
}

class _BpcAppState extends State<BpcApp> {
  late DataManager _dataManager;

  final _localAuth = LocalAuthentication();

  late AppStateManager _appStateManager;

  @override
  void initState() {
    _dataManager = InjectionComponent.getDependency<DataManager>();
    _appStateManager = AppStateManager(key: Navigation.navigatorKey);
    WidgetsBinding.instance.addObserver(_appStateManager);
    _checkBiometrics();
    super.initState();


  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateManager);
    super.dispose();
  }


  Future<void> _checkBiometrics() async {
    _dataManager.authWithBiometricsFlag = await PreferencesHelper.getAuthWithBiometrics();
    try {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (canCheckBiometrics) {
        await _localAuth.getAvailableBiometrics().then((value) {
          _dataManager.availableBiometrics = value;
        });
      } else {
        _dataManager.authWithBiometricsFlag = false;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primary = MaterialColor(4280172154,
    {50: Color(0xffebf0fa),
    100: Color(0xffd6e1f5),
		200: Color(0xffadc3eb),
		300: Color(0xff84a4e1),
		400: Color(0xff5b86d7),
		500: Color(0xff3268cd),
		600: Color(0xff2853a4),
		700: Color(0xff1e3e7b),
		800: Color(0xff142a52),
		900: Color(0xff0a1529),
		});
    return MaterialApp(
      navigatorKey: Navigation.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        RefreshLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        // Locale('en'),
      ],
      title: 'Мой Дом',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppStyles.scaffoldColor,
        appBarTheme: AppBarTheme(
          color: AppStyles.scaffoldColor,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness:Brightness.light),
          elevation: 0,
          iconTheme: Theme.of(context).primaryIconTheme.copyWith(
            color: AppStyles.mainColor
          ),
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppStyles.mainTextColor
          )
          // titleTextStyle: const TextStyle(
          //   color: AppStyles.mainTextColor
          // )
        ),
        primarySwatch: primary,
        secondaryHeaderColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: AppStyles.mainTextColor,
        ),
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
          bodyColor: AppStyles.mainTextColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}