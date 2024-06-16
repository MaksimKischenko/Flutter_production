import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:injector/injector.dart';

import 'data/data.dart';

class InjectionComponent {
  static final InjectionComponent _singleton = InjectionComponent._internal();
  // Use this static instance
  static final Injector injector = Injector.appInstance;

  factory InjectionComponent() => _singleton;

  InjectionComponent._internal();

  static Future<void> run({
    required DynamicConfig config,
  }) async {
    //Inject all
    injector
    ..registerSingleton<Dio>(() {
      final dio = Dio();
        dio.options.connectTimeout = const Duration(milliseconds: 25000);
        dio.options.receiveTimeout = const Duration(milliseconds: 25000);

      // inject debug dependency. перехватчики на запрос и на ответ и на ошибку
      if (kDebugMode) {
        dio.interceptors.add(HttpFormatter());
      }

      return dio;
    })
    // ignore: prefer_expression_function_bodies
    ..registerSingleton<DataManager>(() {
      return DataManager(
        dio: injector.get<Dio>(),
        config: config
      );
      // return RealDataManager(injector.get<Dio>());
      // return FakeDataManager(injector.get<Dio>());
    })
    ..registerSingleton<DynamicConfig>(() => config);
    // ..registerSingleton<PreferencesHelper>(() => PreferencesHelper());
  }

  static T getDependency<T>() => injector.get<T>();
  
}