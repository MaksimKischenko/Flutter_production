import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/injection_component.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/screens/screens.dart';
import 'package:isc_web_app/utils/url_resolver/url_resolver.dart';
import 'package:isc_web_app/utils/utils.dart';



@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class Routes extends $Routes {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: SplashRoute.page,
      path: SplashScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      initial: true,
    ),
    CustomRoute(
      page: ClaimsRoute.page,
      path: ClaimsScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]
    ),     
    CustomRoute(
      page: AuthRoute.page,
      path: AuthScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),   
    CustomRoute(
      page: ProfileRoute.page,
      path: ProfileScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      page: ClaimInfoRoute.page,
      path: '${ClaimInfoScreen.pageRoute}/:id',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),   
    CustomRoute(
      page: RegisterPaymentClaimRoute.page,
      path: '${RegisterPaymentClaimScreen.pageRoute}/:id',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),     
    CustomRoute(
      page: PaymentsISCRoute.page,
      path: PaymentsISCScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),   
    CustomRoute(
      page: PaymentInfoRoute.page,
      path: '${PaymentInfoScreen.pageRoute}/:id',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),  
    CustomRoute(
      page: SettingsRoute.page,
      path: SettingsScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),                    
  ];
}


class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (InjectionComponent.getDependency<DataManager>().token.isNotEmpty) {
      resolver.next(true);
    } else {
      router.pushAndPopUntil(AuthRoute(), predicate: (route) => false);
    }
  }
}


class ISCRouteObserver extends AutoRouterObserver {
  final BuildContext context;
  ISCRouteObserver({required this.context});

  @override
  void didPush(Route route, Route? previousRoute) {
    if(kDebugMode) {
      log('PREVIOUS_ROUTE:\x1B[31m${previousRoute?.settings.name}\x1B[0m');
      log('CURRENT_ROUTE:\x1B[31m${route.settings.name}\x1B[0m');
    }
    if (route.settings.name == 'SplashRoute' && (previousRoute?.settings.name == 'MdomAccrualsRoute')) {
      context.read<AuthBloc>().add(AuthLogOut());
    }
    if (route.settings.name == 'SplashRoute') {
      context.read<AuthBloc>().add(AuthCheck(getAbsolutePath(context)));
    } 
  }
}
