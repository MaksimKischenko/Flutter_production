// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:helppay/firebase_options.dart';
import 'package:helppay/screens/screens.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app_state_manager.dart';
import 'blocs/blocs.dart';
import 'config.dart';
import 'injection_component.dart';
import 'navigation.dart';
import 'screens/auth_change_password_screen/auth_change_password_screen.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'mobile_main');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  final language = await PreferencesHelper.read(PrefsKeys.language);
  LocaleSettings.setLocaleRaw(language!);
  LocaleSettings.setPluralResolver(
    language: 'ru',
    locale: AppLocale.ru,
    cardinalResolver: (n, {zero, one, two, few, many, other}) {
      if (n == 0) {
        return zero ?? other!;
      }

      final fr10 = n % 10;
      final fr100 = n % 100;

      if (fr10 == 1 && fr100 != 11) {
        return one ?? other!;
      }
      if (fr10.clamp(2, 4) == fr10 && fr100.clamp(12, 14) != fr100) {
        return few ?? other!;
      }
      if (fr10 == 0 ||
          fr10.clamp(5, 9) == fr10 ||
          fr100.clamp(11, 14) == fr100) {
        return many ?? other!;
      }
      return other!;
    },
  );
  await InjectionComponent.run();
  Bloc.observer = SimpleBlocObserver();
  Bloc.transformer = sequential<dynamic>();
  runApp(
    TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MenuBloc>(
            create: (context) => MenuBloc(),
          ),
          BlocProvider<RegistrationBloc>(
            create: (context) => RegistrationBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<AuthResetPasswordBloc>(
            create: (context) => AuthResetPasswordBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<PaymentsHistoryBloc>(
            create: (context) => PaymentsHistoryBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<MdomAccrualsBloc>(
            create: (context) => MdomAccrualsBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<MdomDeleteBloc>(
            create: (context) => MdomDeleteBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<QrRequestBloc>(
            create: (context) => QrRequestBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<QrRequestStatusBloc>(
            create: (context) => QrRequestStatusBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<QrHistoryBloc>(
            create: (context) => QrHistoryBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<MdomPollsListBloc>(
            create: (context) => MdomPollsListBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<PaymentMethodBloc>(
            create: (context) => PaymentMethodBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<CardsIssueBloc>(
            create: (context) => CardsIssueBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          // BlocProvider<QrCamBloc>(
          //   create: (context) => QrCamBloc(
          //     dataManager: InjectionComponent.getDependency<DataManager>(),
          //   ),
          // ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<ProfileBloc>().add(ProfileInit());
              context.read<ProductsBloc>().add(ProductsInit());
              context.read<PaymentsHistoryBloc>().add(PaymentsHistoryInit());
            }
          },
          child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationPinSetSuccess) {
                context.read<ProfileBloc>().add(ProfileInit());
                context.read<ProductsBloc>().add(ProductsInit());
                context.read<PaymentsHistoryBloc>().add(PaymentsHistoryInit());
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
              builder: (context) => const HelpPayApp(),
            ),
          ),
        ),
      ),
    ),
  );
}

class HelpPayApp extends StatefulWidget {
  const HelpPayApp({
    Key? key,
  }) : super(key: key);
  @override
  _HelpPayAppState createState() => _HelpPayAppState();
}

class _HelpPayAppState extends State<HelpPayApp> {
  final DataManager _dataManager;
  
  late FirebaseMessaging _firebaseMessaging;

  final _localAuth = LocalAuthentication();

  late AppStateManager _appStateManager;

  _HelpPayAppState()
      : _dataManager = InjectionComponent.getDependency<DataManager>();

  @override
  void initState() {
    _appStateManager = AppStateManager(Navigation.navigatorKey);
    WidgetsBinding.instance.addObserver(_appStateManager);
    if (!kIsWeb) {
      _firebaseMessaging = FirebaseMessaging.instance;
      setupFirebaseMessaging();
    }

    _checkBiometrics();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appStateManager);
    super.dispose();
  }

  // ignore: avoid_void_async
  void _checkBiometrics() async {
    _dataManager.authWithBiometricsFlag =
        (await PreferencesHelper.read(PrefsKeys.authWithBiometric))!;
    try {
      final canCheckBiometrics =
          // ignore: avoid_bool_literals_in_conditional_expressions
          kIsWeb ? false : await _localAuth.canCheckBiometrics;
      if (canCheckBiometrics) {
        unawaited(_localAuth.getAvailableBiometrics().then((value) {
          _dataManager.availableBiometrics = value;
        }));
      } else {
        _dataManager.authWithBiometricsFlag = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void setupFirebaseMessaging() {
    _firebaseMessaging.getToken().then((token) {
      _log('Firebase Token: $token');
      // Здесь вы можете отправить токен на ваш сервер, если это необходимо.
    });

    FirebaseMessaging.onMessage.listen((message) {
      // Обработка уведомления, которое пришло, пока приложение открыто.
      _log('onMessage: $message');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Обработка уведомления, которое пришло, когда приложение было закрыто.
      _log('onMessageOpenedApp: $message');
    });
    _firebaseMessaging
        .subscribeToTopic('t3')
        .then((value) => _log('topic subscrition finished'));
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final path = settings.name;

        Widget Function(BuildContext)? builder;

        if (path == SplashScreen.pageRoute) {
          _dataManager.needCheckPin = false;
          builder = (context) => const SplashScreen();
        } else if (path == AuthScreen.pageRoute) {
          builder = (context) => const AuthScreen();
        } else if (path == MainScreen.pageRoute) {
          builder = (context) => const MainScreen();
        } else if (path == RegistrationScreen.pageRoute) {
          builder = (context) => const RegistrationScreen();
        } else if (path == AuthChangePasswordScreen.pageRoute) {
          builder = (context) => const AuthChangePasswordScreen();
        } else if (path == RegistrationParamsScreen.pageRoute) {
          final args = settings.arguments as RegistrationParamsScreenArgs;

          builder = (context) => RegistrationParamsScreen(
                params: args.params,
                lookUps: args.lookUps,
                phoneNumber: args.phone,
              );
        } else if (path == RegistrationCodeScreen.pageRoute) {
          final args = settings.arguments as RegistrationCodeScreenArgs;

          builder = (context) => RegistrationCodeScreen(
                codeType: args.codeType,
              );
        } else if (path == WebViewScreen.pageRoute) {
          builder = (context) => const WebViewScreen();
        } else if (path == CardCreationScreen.pageRoute) {
          builder = (context) => const CardCreationScreen();
        } else if (path == RegistrationSuccessScreen.pageRoute) {
          builder = (context) => const RegistrationSuccessScreen();
        } else if (path == SettingsScreen.pageRoute) {
          builder = (context) => const SettingsScreen();
        } else if (path == SelectLanguageScreen.pageRoute) {
          builder = (context) => const SelectLanguageScreen();

          return MaterialWithModalsPageRoute<AppLocale>(
            settings: settings,
            builder: builder,
          );
        } else if (path == ProfileScreen.pageRoute) {
          builder = (context) => const ProfileScreen();
        } else if (path == ProfileEditScreen.pageRoute) {
          final args = settings.arguments as ProfileEditScreenArgs;

          builder = (context) => ProfileEditScreen(
                userParams: args.userParams,
                lookups: args.lookups,
              );
        } else if (path == QrHistoryScreen.pageRoute) {
          // final args = settings.arguments as ProfileEditScreenArgs;

          builder = (context) => const QrHistoryScreen(
              // userParams: args.userParams,
              );
        } else if (path == MdomAccrualsScreen.pageRoute) {
          builder = (context) => const MdomAccrualsScreen();
        } else if (path == MdomPollsListScreen.pageRoute) {
          final args = settings.arguments as MdomPollsListScreenArgs;

          builder = (context) => MdomPollsListScreen(
                supplierId: args.supplierId,
                accountsCount: args.accountsCount,
                supplierTitle: args.supplierTitle,
              );
        } else if (path == MdomPollScreen.pageRoute) {
          final args = settings.arguments as MdomPollScreenArgs;

          builder = (context) => BlocProvider<VotePollBloc>(
                create: (context) => VotePollBloc(
                  dataManager: _dataManager,
                  poll: args.poll,
                )..add(VotePollInit()),
                child: MdomPollScreen(
                  participantsCount: args.participantsCount,
                  poll: args.poll,
                ),
              );

          return MaterialWithModalsPageRoute<Poll>(
            settings: settings,
            builder: builder,
          );
        } else if (path == MdomPollStatisticsScreen.pageRoute) {
          final args = settings.arguments as MdomPollStatisticsScreenArgs;

          builder = (context) => MdomPollStatisticsScreen(
                participantsCount: args.participantsCount,
                poll: args.poll,
              );
        } else if (path == MdomNotificationsScreen.pageRoute) {
          final args = settings.arguments as MdomNotificationsListScreenArgs;
          builder = (context) => BlocProvider(
                create: (context) => MdomNotificationsBloc(
                  dataManager: InjectionComponent.getDependency<DataManager>(),
                  supplierId: args.supplierId,
                ),
                child: MdomNotificationsScreen(
                    supplierTitle: args.suppierTitle,
                    supplierId: args.supplierId),
              );
        } else if (path == MdomPollStatisticsQuestionScreen.pageRoute) {
          final args =
              settings.arguments as MdomPollStatisticsQuestionScreenArgs;

          builder = (context) => BlocProvider<MdomPollQuestionInfoBloc>(
                create: (context) => MdomPollQuestionInfoBloc(
                    dataManager: _dataManager,
                    pollId: args.pollId,
                    questionId: args.question.idx)
                  ..add(
                    MdomPollQuestionInfoInit(),
                  ),
                child: MdomPollStatisticsQuestionScreen(
                  question: args.question,
                ),
              );
        }

        builder ??= (context) => const SplashScreen();

        return MaterialWithModalsPageRoute<void>(
          settings: settings,
          builder: builder,
        );
      },
      navigatorKey: Navigation.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        RefreshLocalizations.delegate,
      ],
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      title: CoreConfig.appName,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppStyles.scaffoldColor,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0,
            iconTheme: Theme.of(context)
                .primaryIconTheme
                // .copyWith(color: AppStyles.mainColorDark)),
                .copyWith(color: AppStyles.mainColor)),
        primarySwatch: primary,
        secondaryHeaderColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppStyles.mainColorDark,
            ),
        primaryTextTheme: Theme.of(context)
            .primaryTextTheme
            .apply(bodyColor: AppStyles.mainColorDark),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
