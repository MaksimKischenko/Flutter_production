import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/screens/screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class Routes extends $Routes {
  @override
  List<AutoRoute> get routes => [
      AutoRoute(
      page: SplashRoute.page, 
      path: SplashScreen.pageRoute, 
      initial: true
    ),
    AutoRoute(
      page: MainRouteMobile.page,
      path: MainScreenMobile.pageRoute,
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: FeaturesRoute.page,
      path: FeaturesScreen.pageRoute,
    ),
    AutoRoute(
      page: AuthRoute.page,
      path: AuthScreen.pageRoute,
    ),
    AutoRoute(
      page: AboutAppRoute.page,
      path: AboutAppScreen.pageRoute,
    ),
    AutoRoute(
      page: ProfileRoute.page,
      path: ProfileScreen.pageRoute,
    ),
    AutoRoute(
      page: SettingsRoute.page,
      path: SettingsScreen.pageRoute,
    ),
    AutoRoute(
      page: ServicesQrRoute.page,
      path: ServicesQrScreen.pageRoute,
    ),
    AutoRoute(
      page: RegistrationRoute.page,
      path: RegistrationScreen.pageRoute,
    ),
    AutoRoute(
      page: RegistrationSuccessRoute.page,
      path: RegistrationSuccessScreen.pageRoute,
    ),
    AutoRoute(
      page: RegistrationParamsRoute.page,
      path: RegistrationParamsScreen.pageRoute,
    ),
    AutoRoute(
      page: RegistrationCodeRoute.page,
      path: RegistrationCodeScreen.pageRoute,
    ),
    AutoRoute(
      page: QrCamRoute.page,
      path: QrCamScreen.pageRoute,
    ),
    AutoRoute(
      page: PollRoute.page,
      path: PollScreen.pageRoute,
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: PollStatisticsRoute.page,
      path: PollStatisticsScreen.pageRoute,
    ),
    AutoRoute(
      page: PollStatisticsQuestionRoute.page,
      path: PollStatisticsQuestionScreen.pageRoute,
    ),
    AutoRoute(
      page: PollsListRoute.page,
      path: PollsListScreen.pageRoute,
    ),
    AutoRoute(
      page: PollMembersRoute.page,
      path: PollMembersScreen.pageRoute,
    ),
    AutoRoute(
      page: PollAddRoute.page,
      path: PollAddScreen.pageRouteAdd,
    ),
    AutoRoute(
      page: PollsListFiltersRoute.page,
      path: PollsListFiltersScreen.pageRoute,
    ),
    AutoRoute(
      page: PaymentsRoute.page,
      path: PaymentsScreen.pageRoute,
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: PaymentInfoRoute.page,
      path: PaymentInfoScreen.pageRoute,
    ),
    AutoRoute(
      page: HelpRoute.page,
      path: HelpScreen.pageRoute,
    ),
    AutoRoute(
      page: ClaimsRoute.page,
      path: ClaimsScreen.pageRoute,
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: ClaimPaymentsRoute.page,
      path: ClaimPaymentsScreen.pageRoute,
    ),
    AutoRoute(
      page: ClaimInfoRoute.page,
      path: ClaimInfoScreen.pageRoute,
    ),
    AutoRoute(
      page: ChangePasswordRoute.page,
      path: ChangePasswordScreen.pageRoute,
    ),
  ];
}




class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (InjectionComponent.getDependency<DataManager>().token.isNotEmpty) {
      resolver.next(true);
    } else {
      router.push(const AuthRoute());
    }
  }
}

class BpcRouteObserver extends AutoRouterObserver {
  final BuildContext context;

  BpcRouteObserver({required this.context});
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
    log('Prev route: ${previousRoute?.settings.name}');
    // if (route.settings.name == 'AuthRoute' &&
    //     (previousRoute?.settings.name == 'MainRoute')) {
    //   context.read<AuthMdomBloc>().add(AuthMdomLogOut());
    //   AutoRouter.of(context).push(const AuthRoute());
    // }
    if (route.settings.name == 'AuthRoute' && kIsWeb) {
      context
          .read<AuthMdomBloc>()
          .add(AuthCheck(ModalRoute.of(context)?.settings.name ?? ''));
    }
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('Tab route re-visited: ${route.name}');
  }
}
