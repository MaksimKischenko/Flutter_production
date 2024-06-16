import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/screens.dart';
import 'package:helppay_web_app/utils/url_resolver/url_resolver.dart';

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
          page: AuthRoute.page,
          path: AuthScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: RegistrationRoute.page,
          path: RegistrationScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: RegistrationParamsRoute.page,
          path: RegistrationParamsScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: RegistrationCodeRoute.page,
          path: RegistrationCodeScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: RegistrationSuccessRoute.page,
          path: RegistrationSuccessScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: AuthChangePasswordRoute.page,
          path: AuthChangePasswordScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: PaymentsHistoryRoute.page,
          path: PaymentsHistoryScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: MdomAccrualsRoute.page,
          path: MdomAccrualsScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
          guards: [AuthGuard()],
        ),
        CustomRoute(
          page: ProductsRoute.page,
          path: ProductsScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: ProductAddRoute.page,
          path: ProductAddScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: CardInfoRoute.page,
          path: CardInfoScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: AccountInfoRoute.page,
          path: AccountInfoScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: ProfileRoute.page,
          path: ProfileScreen.pageRoute,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        // CustomRoute(
        //   page: ProfileEditRoute.page,
        //   path: ProfileEditScreen.pageRoute,
        //   transitionsBuilder: TransitionsBuilders.noTransition,
        // ),
        // CustomRoute(
        //   page: SettingsRoute.page,
        //   path: SettingsScreen.pageRoute,
        //   transitionsBuilder: TransitionsBuilders.noTransition,
        // ),
        CustomRoute(
          page: MdomAccountInfoRoute.page,
          path: '${MdomAccountInfoScreen.pageRoute}/:id/:title',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: MdomPollsListRoute.page,
          path: '${MdomPollsListScreen.pageRoute}/:id/:count/:title',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: MdomNotificationsRoute.page,
          path: '${MdomNotificationsScreen.pageRoute}/:id/:title',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: MdomPollRoute.page,
          path: '${MdomPollScreen.pageRoute}/:count/:title',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: MdomPollStatisticsRoute.page,
          path: '${MdomPollStatisticsScreen.pageRoute}/:count',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: MdomPollStatisticsQuestionRoute.page,
          path: '${MdomPollStatisticsQuestionScreen.pageRoute}/:id',
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        // CustomRoute(
        //   page: ChangePasswordScreen,
        //   path: ChangePasswordScreen.pageRoute,
        //   transitionsBuilder: TransitionsBuilders.noTransition,
        // ),
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

class HelppayRouteObserver extends AutoRouterObserver {
  final BuildContext context;
  HelppayRouteObserver({required this.context});

  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      log('PREVIOUS_ROUTE:\x1B[31m${previousRoute?.settings.name}\x1B[0m');
      log('CURRENT_ROUTE:\x1B[31m${route.settings.name}\x1B[0m');
    }
    if (route.settings.name == 'SplashRoute' &&
        (previousRoute?.settings.name == 'MdomAccrualsRoute')) {
      context.read<AuthBloc>().add(AuthLogOut());
    }
    if (route.settings.name == 'SplashRoute') {
      context.read<AuthBloc>().add(AuthCheck(getAbsolutePath(context)));
    }
    if (route.settings.name == 'MdomAccrualsRoute' &&
        previousRoute?.settings.name != 'AuthRoute') {
      context.read<MdomAccrualsBloc>().add(MdomAccrualsInit());
    }
  }
}
