
import 'package:flutter/material.dart';

import 'data/data.dart';
import 'models/models.dart';
import 'screens/screens.dart';


mixin Navigation {

  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Navigate to [SplashScreen]
  static void toSplash() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/',
    (route) => false
  );

  static void toAuth({String? next}) => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    (next?.isEmpty ?? true) ? '/auth' : '/auth?next=$next',
    (route) => false
  );
  
  /// Navigate to [OrganizationsScreen]
  static void toOrganizations() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/organizations',
    (route) => false
  );

  /// Navigate to [OrganizationScreen]
  static void toOrganization(
    Supplier supplier,
  ) => navigatorKey.currentState?.pushNamed(
    '/organization?id=${supplier.id}',
    arguments: OrganizationScreenParams(
      supplier: supplier
    )
  );

  /// Navigate to [OrganizationEditScreen]
  static Future<Supplier?> toOrganizationEdit(
    Supplier supplier,
  ) => navigatorKey.currentState!.pushNamed<Supplier?>(
    '/organization/edit?id=${supplier.id}',
    arguments: OrganizationEditScreenParams(
      supplier: supplier
    )
  );

  /// Navigate to [OrganizationAddScreen]
  static Future<Supplier?> toOrganizationAdd() => navigatorKey.currentState!.pushNamed<Supplier>(
    '/organizations/add',
  );

  /// Navigate to [ServiceAddScreen]
  static Future<SupplierAccount?> toServiceAdd(int organizationId) => navigatorKey.currentState!.pushNamed<SupplierAccount>(
    '/service/add?organizationId=$organizationId'
  );

  /// Navigate to [ServiceEditScreen]
  static Future<SupplierAccount?> toServiceEdit({
    required SupplierAccount service
  }) => navigatorKey.currentState!.pushNamed<SupplierAccount>(
    '/service/edit?id=${service.id}',
    arguments: ServiceEditScreenParams(
      service: service
    )
  );

  /// Navigate to [UsersScreen]
  static void toUsers() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/users',
    (route) => false
  );

  /// Navigate to [UserAddScreen]
  static Future<User?> toUsersAdd() => navigatorKey.currentState!.pushNamed(
    '/users/add',
  );
  
  /// Navigate to [UserEditScreen]
  static Future<User?> toUsersEdit({
    required User user
  }) => navigatorKey.currentState!.pushNamed(
    '/users/edit?id=${user.id}',
    arguments: UserEditScreenParams(
      user: user
    )
  );

  /// Navigate to [AuditScreen]
  static void toAudit() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/audit',
    (route) => false
  );

  static void toAuditArchive() => navigatorKey.currentState?.pushNamed(
    '/audit/archive',
  );

  /// Navigate to [MessagesScreen]
  static void toMessages() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/messages',
    (route) => false
  );

  /// Navigate to [MessageScreen]
  static void toMessage(ServerMessage message) => navigatorKey.currentState?.pushNamed(
    '/message?id=${message.id}',
    arguments: MessageScreenParams(
      message: message
    )
  );

  /// Navigate to [MessageAddScreen]
  static Future<ServerMessage?> toMessageAdd() => navigatorKey.currentState!.pushNamed(
    '/messages/add'
  );

  /// Navigate to [MessageEditScreen]
  static Future<ServerMessage?> toMessageEdit(ServerMessage message) => navigatorKey.currentState!.pushNamed(
    '/message/edit?id=${message.id}',
    arguments: MessageEditScreenParams(
      message: message
    )
  );

  static void toJobsManager() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/jobs_manager',
    (route) => false
    );

  static Future<Job?> toJobAdd() => navigatorKey.currentState!.pushNamed<Job>(
    '/job/add',
  );

  static Future<Job?> toJobsEdit({
    required Job job
  }) => navigatorKey.currentState!.pushNamed(
    '/job/edit?id=${job.id}',
    arguments: JobEditScreenParams(
      job: job
    )
  );

  static Future<JobPart?> toJobsPartAdd(int id) => navigatorKey.currentState!.pushNamed<JobPart>(
    '/job_part/add?id=$id',
  );

  static Future<JobPart?> toJobsPartEdit({
    required JobPart jobPart
  }) => navigatorKey.currentState!.pushNamed(
    '/job_part/edit?id=${jobPart.jobPartId}',
    arguments: JobPartEditScreenParams(
      jobPart: jobPart
    )
  );

  static Future<String?> toJobsPartRun({
    required JobPart jobPart
  }) => navigatorKey.currentState!.pushNamed<String>(
    '/job_part/run?id=${jobPart.jobPartId}',
    arguments: JobPartEditScreenParams(
      jobPart: jobPart
    )
  );

  static Future<JobPartParam?> toJobsPartParamAdd(int jobPartId) => navigatorKey.currentState!.pushNamed<JobPartParam>(
    '/job_part_param/add?jobPartId=$jobPartId',
  );

  static Future<JobPartParam?> toJobsPartParamEdit({
    required JobPartParam jobPartParam
  }) => navigatorKey.currentState!.pushNamed(
    '/job_part_param/edit?id=${jobPartParam.jobPartParamId}',
    arguments: JobPartParamEditScreenParams(
      jobPartParam: jobPartParam
    )
  );

  static void toSettings() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/settings',
    (route) => false
  );

}