

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fl_qr_module/config.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/screens/screens.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'blocs/blocs.dart';
import 'blocs/simple_bloc_observer.dart';
import 'generated/translations.g.dart';
import 'injection_component.dart';
import 'navigation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
          BlocProvider<NativeHostAuthBloc>(
            create: (context) => NativeHostAuthBloc(
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
          // BlocProvider<QrCamBloc>(
          //   create: (context) => QrCamBloc(
          //     dataManager: InjectionComponent.getDependency<DataManager>(),
          //   ),
          // ),
        ],
        child: const QrModule(),
        ),
      ),
    );
}

class QrModule extends StatefulWidget {
  const QrModule({
    Key? key,
  }) : super(key: key);
  @override
  _QrModuleState createState() => _QrModuleState();
}

class _QrModuleState extends State<QrModule> {


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
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final path = settings.name;

        Widget Function(BuildContext)? builder;

        if (path == NativeHostSplashScreen.pageRoute) {
          builder = (context) => const NativeHostSplashScreen();
        } else if (path == MainScreen.pageRoute) {
          builder = (context) => const MainScreen();
        } else if (path == QrHistoryScreen.pageRoute) {
          builder = (context) => const QrHistoryScreen();
        }

        builder ??= (context) => const NativeHostSplashScreen();

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
      ],
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
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
