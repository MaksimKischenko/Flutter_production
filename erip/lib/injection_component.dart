
import 'dart:io';

import 'package:bpc_nkfo/data/data.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';

class InjectionComponent {
  static final InjectionComponent _singleton = InjectionComponent._internal();
  // Use this static instance
  static final Injector injector = Injector.appInstance;

  factory InjectionComponent() => _singleton;

  InjectionComponent._internal();

  static Future<void> run() async {
    //Inject all
    injector
      ..registerSingleton<Dio>(() {
        final dio = Dio();
        (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            return client; 
        };
    dio.options.connectTimeout = const Duration(milliseconds: 10000);
    dio.options.receiveTimeout = const Duration(milliseconds: 25000);

        // inject debug dependency
        if (kDebugMode) {
          // final alice =  Alice(showNotification: false, showInspectorOnShake: true, darkTheme: true)..setNavigatorKey(Navigation.navigatorKey);
          // dio.interceptors.add(InterceptorsWrapper(
          //   onRequest: (options, handler) {
          //     //logger.i(options.uri);
          //     logger.i(options.data);
          //     return handler.next(options);
          //   },
          //   onResponse: (response, handler) {
          //     logger.i(response.data);
          //     return handler.next(response);
          //   },
          //   onError: (e, handler) {
          //     logger.e(e.message);
          //     return handler.next(e);
          //   }
          // ));

          dio.interceptors.add(HttpFormatter());

          // dio.interceptors.add(alice.getDioInterceptor());
        }

        return dio;
      })
      ..registerSingleton<DataManager>(() {
        final dio = injector.get<Dio>();
        // return FakeDataManager(dio);
        return RealDataManager(dio);
      })
      ..registerSingleton<PreferencesHelper>(PreferencesHelper.new);
  }

  static T getDependency<T>() => injector.get<T>();
  
}