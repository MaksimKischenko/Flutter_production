// ignore_for_file: avoid_void_async

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kpm_fl/styles.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/blocs.dart';
import 'config.dart';
import 'data/data.dart';
import 'injection_component.dart';
import 'models/models.dart';
import 'navigation.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';
import 'widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionComponent.run();
  // runApp(KpmApp());
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
      () => runApp(MultiBlocProvider(
              providers: [
                BlocProvider<ScreenInfoBloc>(
                    create: (context) => ScreenInfoBloc(
                        dataManager:
                            InjectionComponent.getDependency<DataManager>(),
                        defaultData: AppConfig.screenData)
                      ..add(ScreenInfoLoad())),
                BlocProvider<SettingsBloc>(
                    create: (context) => SettingsBloc(
                          dataManager:
                              InjectionComponent.getDependency<DataManager>(),
                        )..add(SettingsInit())),
                BlocProvider<BasketBloc>(
                    create: (context) => BasketBloc(
                          dataManager:
                              InjectionComponent.getDependency<DataManager>(),
                        ) //..add(BasketInit())
                    ),
                BlocProvider<CheckConnectionBloc>(
                    create: (context) => CheckConnectionBloc(
                          dataManager:
                              InjectionComponent.getDependency<DataManager>(),
                        ) //..add(CheckConnectionInit())
                    ),
                BlocProvider<CheckSessionBloc>(
                    create: (context) => CheckSessionBloc(
                          dataManager:
                              InjectionComponent.getDependency<DataManager>(),
                        ) //..add(CheckConnectionInit())
                    ),
              ],
              child: BlocListener<CheckConnectionBloc, CheckConnectionState>(
                listener: (context, state) {
                  if (state is CheckConnectionSuccess) {
                  } else if (state is CheckConnectionError) {
                  } else if (state is CheckConnectionErrorKomplat) {}
                },
                child: CheckSessionWrapper(
                  child: SettingsInfoWrapper(
                      child: ScreenInfoWrapper(
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
                    defaultDevice: DeviceInfo.genericTablet(
                      platform: TargetPlatform.iOS,
                      id: 'ipad',
                      name: 'iPad',
                      pixelRatio: 2,
                      screenSize: const Size(810, 1080),
                      safeAreas: const EdgeInsets.only(
                        left: 0,
                        top: 20,
                        right: 0,
                        bottom: 0,
                      ),
                      rotatedSafeAreas: const EdgeInsets.only(
                        left: 0,
                        top: 20,
                        right: 0,
                        bottom: 0,
                      ),
                      // framePainter: const _FramePainter(),
                      // screenPath: _screenPath,
                    ),
                    builder: (context) => KpmApp(),
                  ))),
                ),
              ))),
      blocObserver: SimpleBlocObserver(),
      eventTransformer: sequential<dynamic>());
}

class KpmApp extends StatelessWidget {
  static const primary = MaterialColor(4283157653, {
    50: Color(0xffebf9f3),
    100: Color(0xffd7f4e8),
    200: Color(0xffb0e8d0),
    300: Color(0xff88ddb9),
    400: Color(0xff60d2a1),
    500: Color(0xff38c78a),
    600: Color(0xff2d9f6e),
    700: Color(0xff227753),
    800: Color(0xff174f37),
    900: Color(0xff0b281c)
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: '/',
        // initialRoute: '/test',
        onGenerateRoute: (settings) {
          final path = settings.name;

          Widget Function(BuildContext)? builder;

          if (path == SplashScreen.pageRoute) {
            builder = (context) => const SplashScreen();
          } else if (path == PopularServicesScreen.pageRoute) {
            builder = (context) => BlocProvider<PopularServicesBloc>(
                create: (context) => PopularServicesBloc(
                    dataManager:
                        InjectionComponent.getDependency<DataManager>())
                  ..add(PopularServicesInit()),
                child: const PopularServicesScreen());
          } else if (path == InfoScreen.pageRoute) {
            builder = (context) => const InfoScreen();
          } else if (path == SettingsScreen.pageRoute) {
            builder = (context) => const SettingsScreen();
          } else if (path == ServicesScreen.pageRoute) {
            final args = settings.arguments as ServicesScreenArgs;

            builder = (context) => BlocProvider<ServicesBloc>(
                  create: (context) => ServicesBloc(
                      dataManager:
                          InjectionComponent.getDependency<DataManager>(),
                      code: args.code)
                    ..add(ServicesInit()),
                  child: ServicesScreen(code: args.code),
                );
          } else if (path == BasketScreen.pageRoute) {
            builder = (context) => const BasketScreen();
          } else if (path == ServiceScreen.pageRoute) {
            final args = settings.arguments as ServiceScreenArgs;

            builder = (context) => BlocProvider<PaymentBloc>(
                  create: (context) => PaymentBloc(
                    dataManager:
                        InjectionComponent.getDependency<DataManager>(),
                  ),
                  child: ServiceScreen(code: args.code),
                );
          } else if (path == CheckScreen.pageRoute) {
            final args = settings.arguments as CheckScreenArgs;

            builder = (context) => BlocProvider<CheckBloc>(
                  create: (context) => CheckBloc(
                      dataManager:
                          InjectionComponent.getDependency<DataManager>(),
                      barcode: args.barcode)
                    ..add(CheckInit()),
                  child: CheckScreen(
                    barcode: args.barcode,
                  ),
                );
          }

          builder ??= (context) => const SplashScreen();

          return NoAnimationMaterialPageRoute<void>(
              settings: settings,
              // TODO: remove textScaleFactor
              builder: (context) => Builder(builder: (context) {
                    final mediaQueryData = MediaQuery.of(context);

                    return MediaQuery(
                      data: mediaQueryData.copyWith(textScaleFactor: 1.5),
                      child: BlocListener<CheckSessionBloc, CheckSessionState>(
                        listener: (context, state) {
                          if (state is CheckSessionLogOut) {
                            // print('current route name: ${ModalRoute.of(context)?.settings.name}');
                            if (ModalRoute.of(context)?.settings.name !=
                                PopularServicesScreen.pageRoute) {
                              Navigation.toPopularServices();
                            }
                            final basketBloc = context.read<BasketBloc>();
                            if (!basketBloc.isBasketEmpty) {
                              basketBloc.add(BasketDeleteAllPayments());
                            }
                          }
                        },
                        child: builder!(context),
                      ),
                    );
                  }));
        },
        // onGenerateRoute: (settings) {
        //   // print('path: ${settings.name}');
        //   final parsed = RouteHelper.parsePath(settings.name ?? '', isHashStrategy: false, urlAppender: '');
        //   final path = parsed.key;
        //   final params = parsed.value;
        //   print(params);

        //   setPageTitle(context, _names[path] ?? '404');

        //   Widget Function(BuildContext)? builder;

        //   if (path == SplashScreen.pageRoute) {
        //     builder = (context) => const SplashScreen();
        //     // builder = (context) => const TestScreen();
        //   } else if (path == HomeScreen.pageRoute) {
        //     builder = (context) => const HomeScreen();
        //   }

        //   builder ??= (context) => const SplashScreen();

        //   return NoAnimationMaterialPageRoute<void>(
        //     settings: settings,
        //     builder: builder
        //   );
        // },
        navigatorKey: Navigation.navigatorKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // RefreshLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
          //const Locale('en'),
        ],
        title: AppConfig.appName,
        theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: AppStyles.scaffoldColor,
          appBarTheme: AppBarTheme(
            color: AppStyles.scaffoldColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light),
            elevation: 0,
            iconTheme: Theme.of(context)
                .primaryIconTheme
                .copyWith(color: AppStyles.mainTextColor),
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
