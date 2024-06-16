import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';


class RoutesActionService  {
  final DataManager dataManager;

  RoutesActionService._()
    : dataManager = getIt<DataManager>();

  static final _instance = RoutesActionService._();
  static RoutesActionService get instance => _instance;


  final Map<int, Iterable<AutoRoute>> _mapByRoles = {
    UserTypeRoleById.admin.id: Routes().routes.where((element) => element.name != PaymentsRoute.name && element.name != AuthRoute.name), //Даже AuthRoute разлогинит
    UserTypeRoleById.user.id: Routes().routes.where((element) => element.name == PaymentsRoute.name).toList(), //Даже AuthRoute разлогинит
    UserTypeRoleById.userViewer.id: Routes().routes.where((element) => element.name == UsersRoute.name).toList(),     //Даже AuthRoute разлогинит
  };    

  void didPushActions(BuildContext context, Route route, Route? previousRoute) {
    if(kDebugMode) {
      log('PREVIOUS_ROUTE:\x1B[31m${previousRoute?.settings.name}\x1B[0m');
      log('CURRENT_ROUTE:\x1B[31m${route.settings.name}\x1B[0m');
    }
    if(!_allowedRoutes().contains(route.settings.name)) {
      if(route.settings.name != null) {
        context.read<AuthBloc>().add(AuthLogOut());
      }
    } else {
      _loadScreensInfo(route, context);
    }
  }

  Iterable<String> _allowedRoutes() {
    final _currentRouteKey =  dataManager.tokendata?.userType;
    if(_currentRouteKey != null) {
      return _mapByRoles[_currentRouteKey.id]?.map((e) => e.name) ?? [];
    }
    return [AuthRoute.name];
  } 

  void _loadScreensInfo(Route route, BuildContext context) {
    switch (route.settings.name) {
      case UsersRoute.name:
        context.read<UsersBloc>().add(UsersInit(typeId: UserTypeRoleById.user.id));
        break;
      case UserAddRoute.name:
        context.read<UserInsertBloc>().add(UserInsertInit());
        break;                   
      case AuditLogRoute.name:
        context.read<AuditLogBloc>().add(const AuditLogInit());
        break;   
      case RuleAllocationAddRoute.name:
        context.read<RuleAllocationInsertBloc>().add(RuleAllocationInsertInit());
        break; 
      case RuleAlloctionsRoute.name:     
        context.read<RuleAllocationBloc>().add(RuleAllocationInit());
        break; 
      case ArchivesDirectoryRoute.name:     
        context.read<ArchiveDbBloc>().add(ArchiveDbInit());
        break; 
      case ArchiveStatusRoute.name:     
        context.read<ArchiveStatusBloc>().add(ArchiveStatusInit());
        break;  
      case ArchiveLocationRoute.name:     
        context.read<ArchiveLocationBloc>().add(ArchiveLocationInit());
        break;       
      case ArchiveLocationAddRoute.name:     
        context.read<ArchiveLocationInsertBloc>().add(ArchiveLocationInsertInit());
        break;    
      case DataSourceDirectoryRoute.name:     
        context.read<DataSourceBloc>().add(DataSourceInit());
        break;   
      case DataSourceAddRoute.name:     
        context.read<DataSourceInsertBloc>().add(DataSourceInsertInit());
        break;                                                                                           
    }
  }
}

