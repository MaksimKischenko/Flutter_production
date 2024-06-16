import 'package:auto_route/auto_route.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bpc/data/routing/routes.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/styles.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:new_version/new_version.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/blocs.dart';
import 'config.dart';
import 'data/data.dart';
import 'utils/utils.dart';

final getIt = GetIt.instance;

void main() async {
  getIt.registerSingleton<Routes>(Routes());

  WidgetsFlutterBinding.ensureInitialized();

  //final newVersion = NewVersion();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  await InjectionComponent.run();

  BlocOverrides.runZoned(
    () => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<FeaturesBloc>(
            create: (context) => FeaturesBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<MenuBloc>(
            create: (context) => MenuBloc(),
          ),
          BlocProvider<AuthMdomBloc>(
            create: (context) => AuthMdomBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<RegistrationBloc>(
            create: (context) => RegistrationBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<QrCamBloc>(
            create: (context) => QrCamBloc()..add(QrCamPermissionCheck()),
          ),
          BlocProvider<ClaimsBloc>(
            create: (context) => ClaimsBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<PaymentsBloc>(
            create: (context) => PaymentsBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<ServicesQrBloc>(
            create: (context) => ServicesQrBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<PollsListBloc>(
            create: (context) => PollsListBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<InfoBloc>(
            create: (context) => InfoBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
        ],
        child: BlocListener<AuthMdomBloc, AuthMdomState>(
          listener: (context, state) {
            if (state is AuthMdomSuccessLogin) {
              context.read<FeaturesBloc>().add(FeaturesInit());
              context.read<ServicesQrBloc>().add(ServicesQrInit());
              context.read<SettingsBloc>().add(SettingsInit());
              // newVersion.showAlertIfNecessary(context: context);
            }
          },
          child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationSuccess) {
                context.read<FeaturesBloc>().add(FeaturesInit());
                context.read<ServicesQrBloc>().add(ServicesQrInit());
                context.read<SettingsBloc>().add(SettingsInit());
              }
            },
            child: DevicePreview(
              enabled: AppConfig.showFakeDeviceFrame,
              tools: const [
                DeviceSection(
                  frameVisibility: false,
                ),
                // SystemSection(),
                AccessibilitySection(
                  accessibleNavigation: false,
                  invertColors: false,
                ),
                // SettingsSection(),
              ],
              builder: (context) => BpcApp(),
            ),
          ),
        ),
      ),
    ),
    blocObserver: SimpleBlocObserver(),
    eventTransformer: sequential<dynamic>(),
  );
}

class BpcApp extends StatefulWidget {
  @override
  _BpcAppState createState() => _BpcAppState();
}

class _BpcAppState extends State<BpcApp> {
  late DataManager _dataManager;

  final _localAuth = LocalAuthentication();

  // late AppStateManager _appStateManager;

  @override
  void initState() {
    _dataManager = InjectionComponent.getDependency<DataManager>();
    // _appStateManager = AppStateManager(key: Navigation.navigatorKey);
    // WidgetsBinding.instance.addObserver(_appStateManager);
    super.initState();

    _checkBiometrics();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(_appStateManager);
    super.dispose();
  }

  // ignore: avoid_void_async
  void _checkBiometrics() async {
    _dataManager.authWithBiometricsFlag =
        (await PreferencesHelper.read(PrefsKeys.authWithBiometric))!;
    try {
      final canCheckBiometrics =
          kIsWeb ? false : await _localAuth.canCheckBiometrics;
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

  static const primary = MaterialColor(4281883028, {
    50: Color(0xffecf1f8),
    100: Color(0xffdae2f1),
    200: Color(0xffb5c6e3),
    300: Color(0xff90a9d5),
    400: Color(0xff6b8cc7),
    500: Color(0xff466fb9),
    600: Color(0xff385994),
    700: Color(0xff2a436f),
    800: Color(0xff1c2c4a),
    900: Color(0xff0e1625)
  });

  @override
  Widget build(BuildContext context) {
    final router = getIt<Routes>();

    return MaterialApp.router(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      routerDelegate: AutoRouterDelegate(
        router,
        navigatorObservers: () => [BpcRouteObserver(context: context)],
      ),
      routeInformationParser:
          router.defaultRouteParser(includePrefixMatches: true),
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
      scrollBehavior: kIsWeb ? CustomScrollBehavior() : null,
      title: AppConfig.appName,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppStyles.scaffoldColor,
        appBarTheme: AppBarTheme(
          color: AppStyles.scaffoldColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0,
          iconTheme: Theme.of(context)
              .primaryIconTheme
              .copyWith(color: AppStyles.mainColor),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppStyles.mainTextColor),
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
    );
  }
}
