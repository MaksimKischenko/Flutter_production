import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data_manager.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class MenuElementType {
    Map<String, Icon> menuMainElements = {};
    static Map<String, List<String>> menuExpandedElementsList  = {};

    MenuElementType() {
      switch (getIt<DataManager>().tokendata?.userType) {
        case UserTypeRoleById.admin:
          menuMainElements = {
            TabNames.administration.message: Icon(Icons.add_moderator_outlined, size: 16, color: AppStyles.colorUnSelected),     
            TabNames.manageArchAccess.message: Icon(Icons.archive, size: 16, color: AppStyles.colorUnSelected),                          
         };  
          menuExpandedElementsList = {
            TabNames.administration.message: [TabNames.auditLog.message, TabNames.users.message, TabNames.confArchSettings.message],
            TabNames.manageArchAccess.message:[TabNames.archDir.message, TabNames.dataDir.message, TabNames.noDataDir.message, TabNames.statusDir.message]
        };
        case UserTypeRoleById.user:
          menuMainElements = {
            TabNames.payments.message: Icon(Icons.payments_outlined, size: 16, color: AppStyles.colorUnSelected),   
          };        
        case UserTypeRoleById.userViewer:
          menuMainElements = {
            TabNames.users.message: Icon(Icons.person_2_outlined, size: 16, color: AppStyles.colorUnSelected),                               
         };             
        case null:
      }
    }

  static final Map<String, PageRouteInfo<dynamic>> menuElementsToNavigation = {
    TabNames.payments.message: const PaymentsRoute(),
    TabNames.auditLog.message: const AuditLogRoute(),
    TabNames.users.message: const UsersRoute(),
    TabNames.confArchSettings.message: const RuleAlloctionsRoute(),
    TabNames.archDir.message: const ArchivesDirectoryRoute(),
    TabNames.dataDir.message: const DataSourceDirectoryRoute(),
    TabNames.noDataDir.message: const ArchiveLocationRoute(),
    TabNames.statusDir.message: const ArchiveStatusRoute()  
  };
}

enum TabNames {
  payments('Платежи'),
  administration('Администрирование'),
  auditLog('Журнал аудита'),
  users('Пользователи'),
  confArchSettings('Правила распределения архивов'),
  manageArchAccess('Управление архивами'),
  archDir('Архивы'),
  dataDir('Справочник источников данных'),
  noDataDir('Справочник локаций баз данных'),
  statusDir('Справочник статусов');

  const TabNames(this.message);
  final String message;
}
