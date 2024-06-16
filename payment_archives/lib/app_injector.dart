import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/data/remote/archives_api.dart';
import 'package:payment_tracking_module/main.dart';

import 'presentation/routing/routes.dart';


mixin AppInjector {

  static const String baseURL = String.fromEnvironment('belarusbankApiUrl', defaultValue: 'http://192.168.253.178:5539');

  static Future<void> run () async {

    final dio = Dio();
    dio.options.connectTimeout = const Duration(milliseconds: 10000);
    dio.options.receiveTimeout = const Duration(milliseconds: 25000);
    if (kDebugMode) {
      dio.interceptors.add(HttpFormatter());
    }

    getIt
    ..registerSingleton<Routes>(Routes())
    ..registerSingleton<DataManager>(
      DataManager()
    )    
    ..registerSingleton<ChangePasswordRepositoryImpl>(
      ChangePasswordRepositoryImpl(
      dataManager: getIt<DataManager>(),
      changePasswordApi: ChangePasswordApi(
        dio, 
        baseUrl: baseURL
    )))
    ..registerSingleton<TokenRepositoryImpl>(
      TokenRepositoryImpl(
      dataManager: getIt<DataManager>(),
      tokenApi: GetTokendApi(
        dio, 
        baseUrl: baseURL
    ))) 
     ..registerSingleton<ArchivesRepositoryImpl>(
      ArchivesRepositoryImpl(
      dataManager: getIt<DataManager>(),
      archivesApi: ArchivesApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<ArchiveLocationsRepositoryImpl>(
      ArchiveLocationsRepositoryImpl(
      dataManager: getIt<DataManager>(),
      archiveLocationsApi: ArchiveLocationsApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<RuleAllocationDataRepositoryImpl>(
      RuleAllocationDataRepositoryImpl(
      dataManager: getIt<DataManager>(),
      ruleAllocationDataApi: RuleAllocationDataApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<DataSourcesRepositoryImpl>(
      DataSourcesRepositoryImpl(
      dataManager: getIt<DataManager>(),
      dataSourcesApi: DataSourcesApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<UsersRepositoryImpl>(
      UsersRepositoryImpl(
      dataManager: getIt<DataManager>(),
      usersApi: UsersApi(
        dio, 
        baseUrl: baseURL
    )))     
     ..registerSingleton<UserTypeRepositoryImpl>(
      UserTypeRepositoryImpl(
      dataManager: getIt<DataManager>(),
      userTypeApi: UserTypeApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<AuditLogRepositoryImpl>(
      AuditLogRepositoryImpl(
      dataManager: getIt<DataManager>(),
      auditLogApi: AuditLogApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<MapAllocationsRepositoryImpl>(
      MapAllocationsRepositoryImpl(
      dataManager: getIt<DataManager>(),
      mapAllocationsApi: MapAllocationsApi(
        dio, 
        baseUrl: baseURL
    )))    
     ..registerSingleton<ArchivePartsRepositoryImpl>(
      ArchivePartsRepositoryImpl(
      dataManager: getIt<DataManager>(),
      archivePartsApi: ArchivePartsApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<AvailableArchiveLocationRepositoryImpl>(
      AvailableArchiveLocationRepositoryImpl(
      dataManager: getIt<DataManager>(),
      availableArchiveLocationsApi: AvailableArchiveLocationsApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<ArchiveStatusRepositoryImpl>(
      ArchiveStatusRepositoryImpl(
      dataManager: getIt<DataManager>(),
      archiveStatusApi: ArchiveStatusApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<PaymentsRepositiryImpl>(
      PaymentsRepositiryImpl(
      dataManager: getIt<DataManager>(),
      paymentsApi: PaymentsApi(
        dio, 
        baseUrl: baseURL
    )))
     ..registerSingleton<InfoReportsRepositoryImpl>(
      InfoReportsRepositoryImpl(
      dataManager: getIt<DataManager>(),
      infoReportsApi: InfoReportsApi(
        dio, 
        baseUrl: baseURL
    )));                                    
  }
}

