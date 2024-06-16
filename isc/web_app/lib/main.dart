
import 'package:auto_route/auto_route.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/config.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/routing/routes.dart';
import 'package:isc_web_app/styles.dart';
import 'blocs/simple_bloc_observer.dart';
import 'injection_component.dart';
import 'routing/routes.gr.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<Routes>(Routes());

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

  runApp(TranslationProvider(
    child: MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc()..add(SettingsInit()),
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
        BlocProvider<RegisterPaymentClaimBloc>(
          create: (context) => RegisterPaymentClaimBloc(
            dataManager: InjectionComponent.getDependency<DataManager>(),
          ),
        ),                         
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.read<ProfileBloc>().add(ProfileInit());
            //_startRefreshTokenTimer(context);
          } else if (state is AuthLogOutSuccess) {
            getIt<Routes>().pushAndPopUntil(AuthRoute(), predicate: (route) => false);
            // _refreshTokenTimer.cancel();
            // _initRefreshTokenTimer = false;
          }
        },
        child: ISCApp(),
      ),
    ),
  ));
}

// void _startRefreshTokenTimer(BuildContext context) {
//     if (_initRefreshTokenTimer == false) {
//         _initRefreshTokenTimer = true;
//         const duration = Duration(minutes: 15);
//         _refreshTokenTimer = Timer.periodic(duration, (time) {
//             context.read<AuthBloc>().add(AuthRefreshToken(token: InjectionComponent.getDependency<DataManager>().token));
//         });
//     }
// }

class ISCApp extends StatefulWidget {
  @override
  _ISCAppState createState() => _ISCAppState();
}

class _ISCAppState extends State<ISCApp> {


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
        // routerConfig: router.config(
        //   navigatorObservers: () => [ISCRouteObserver(context: context)],
        // ),      
      routerDelegate: AutoRouterDelegate(
        router,
        navigatorObservers: () => [ISCRouteObserver(context: context)],
      ),
      routeInformationParser:
          router.defaultRouteParser(includePrefixMatches: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: LocaleSettings.supportedLocales,
      title: AppConfig.appName,
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
