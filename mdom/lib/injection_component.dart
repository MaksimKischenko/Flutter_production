import 'package:bpc/data/data.dart';
import 'package:dio/dio.dart';
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
        dio.options.connectTimeout = const Duration(milliseconds: 25000);
        dio.options.receiveTimeout = const Duration(milliseconds: 25000);

      // inject debug dependency
      if (kDebugMode) {
        // var alice =  Alice(showNotification: false, showInspectorOnShake: true, darkTheme: true)..setNavigatorKey(Navigation.navigatorKey);
        dio.interceptors.add(HttpFormatter());

        // dio.interceptors.add(alice.getDioInterceptor());
      }

      return dio;
    })
    ..registerSingleton<DataManager>(() {
      final dio = injector.get<Dio>();
      return RealDataManager(dio);
      // return FakeDataManager(dio);
    })
    ..registerSingleton<PreferencesHelper>(PreferencesHelper.new);
  }

  static T getDependency<T>() => injector.get<T>();
  
}