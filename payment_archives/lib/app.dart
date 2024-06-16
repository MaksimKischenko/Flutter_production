
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:payment_tracking_module/app_config.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/routing/routes.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = getIt<Routes>();
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        router,
        navigatorObservers: () => [AppRouteObserver(context: context)],
      ),
      routeInformationParser: router.defaultRouteParser(includePrefixMatches: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
      ],
      title: AppConfig.appName,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.transparent)
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          iconTheme: Theme.of(context).primaryIconTheme.copyWith(color: AppStyles.mainColor)
        ),
        iconTheme: const IconThemeData(
          color: AppStyles.whiteColor
        ),
        primarySwatch: AppStyles.primarySwatch,
        secondaryHeaderColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: AppStyles.mainTextColor),
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(bodyColor: AppStyles.mainColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      )
    );
  }
}
