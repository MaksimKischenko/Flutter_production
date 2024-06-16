

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/data/data_manager.dart';
import 'package:payment_tracking_module/domain/services/routes_action_service.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/screens/screens.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class Routes extends $Routes {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: AuthRoute.page,
      path: AuthScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      initial: true
    ),
    CustomRoute(
      page: PaymentsRoute.page,
      path: PaymentsScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]
    ), 
    CustomRoute(
      page: UsersRoute.page,
      path: UsersScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]
    ),    
    CustomRoute(
      page: AuditLogRoute.page,
      path: AuditLogScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()] 
    ), 
    CustomRoute(
      page: UserAddRoute.page,
      path: UserAddScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()] 
    ),    
    CustomRoute(
      page: UserEditRoute.page,
      path: '${UserEditScreen.pageRoute}/:id', 
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]  
    ),          
    CustomRoute(
      page: RuleAlloctionsRoute.page,
      path: RuleAlloctionsScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]  
    ), 
    CustomRoute(
      page: RuleAllocationAddRoute.page,
      path: RuleAllocationAddScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()] 
    ),    
    CustomRoute(
      page: RuleAllocationEditRoute.page,
      path: '${RuleAllocationEditScreen.pageRoute}/:id', 
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()] 
    ),          
    CustomRoute(
      page: ArchivesDirectoryRoute.page,
      path: ArchivesDirectoryScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()] 
    ), 
    CustomRoute(
      page: ArchivePartRoute.page,
      path: '${ArchivePartScreen.pageRoute}/:id', 
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),   
    CustomRoute(
      page: MapAllocationRoute.page,
      path: '${MapAllocationScreen.pageRoute}/:id', 
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),        
    CustomRoute(
      page: DataSourceDirectoryRoute.page,
      path: DataSourceDirectoryScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),  
    CustomRoute(
      page: DataSourceAddRoute.page,
      path: DataSourceAddScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ), 
    CustomRoute(
      page: DataSourceEditRoute.page,
      path: '${DataSourceEditScreen.pageRoute}/:id', 
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),               
    CustomRoute(
      page: AvailableArchiveLocationRoute.page,
      path: '${AvailableArchiveLocationScreen.pageRoute}/:source_id', 
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),  
    CustomRoute(
      page: ArchiveLocationRoute.page,
      path: ArchiveLocationScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ), 
    CustomRoute(
      page: ArchiveLocationAddRoute.page,
      path: ArchiveLocationAddScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),  
    CustomRoute(
      page: ArchiveLocationEditRoute.page,
      path: '${ArchiveLocationEditScreen.pageRoute}/:id', 
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),         
    CustomRoute(
      page: ArchiveStatusRoute.page,
      path: ArchiveStatusScreen.pageRoute,
      transitionsBuilder: TransitionsBuilders.noTransition,
      guards: [AuthGuard()]      
    ),                         
  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if ((getIt<DataManager>().accessToken ?? '').isNotEmpty) {
      resolver.next(true);
    } else {
      router.pushAndPopUntil(const AuthRoute(), predicate: (route) => false);
    }
  }
}

class AppRouteObserver extends AutoRouterObserver {
  final BuildContext context;
  final RoutesActionService routesActionService;
  AppRouteObserver({required this.context}) : 
  routesActionService = RoutesActionService.instance;
    
  @override
  void didPush(Route route, Route? previousRoute) {
    routesActionService.didPushActions(context, route, previousRoute);
  }
}
