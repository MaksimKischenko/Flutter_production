import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/blocs/menu/menu_bloc.dart';
import 'package:helppay_web_app/routing/routes.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'injection_component.dart';


// final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GetIt locator = GetIt.instance;

  // void setupLocator() {
  //   locator.registerSingleton<Routes>(Routes());
  // }
  //setPathUrlStrategy();

  // getIt.registerSingleton<Routes>(Routes());

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
        BlocProvider<MdomPollsListBloc>(
          create: (context) => MdomPollsListBloc(
            dataManager: InjectionComponent.getDependency<DataManager>(),
          ),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.read<ProfileBloc>().add(ProfileInit());
            context.read<ProductsBloc>().add(ProductsInit());
            context.read<PaymentsHistoryBloc>().add(PaymentsHistoryInit());
            context.read<MdomAccrualsBloc>().add(MdomAccrualsInit());
          }
        },
        child: HelpPayApp(),
      ),
    ),
  ));
}

class HelpPayApp extends StatefulWidget {
  @override
  _HelpPayAppState createState() => _HelpPayAppState();
}

class _HelpPayAppState extends State<HelpPayApp> {
  final _router = Routes();

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
  Widget build(BuildContext context) =>
      // final router =             AutoRouter.of(context) ;
      MaterialApp.router(
        routerConfig: _router.config(
          navigatorObservers: () => [HelppayRouteObserver(context: context)],
        ),
        // routerDelegate: AutoRouterDelegate(
        //   _router,
        //   navigatorObservers: () => [HelppayRouteObserver(context: context)],
        // ),
        // routeInformationParser:
        //     _router.defaultRouteParser(includePrefixMatches: true), //TODO
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          RefreshLocalizations.delegate,
        ],
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: LocaleSettings.instance.supportedLocales,
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
