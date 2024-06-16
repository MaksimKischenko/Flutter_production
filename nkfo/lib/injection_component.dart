import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';


import 'data/data.dart';


class InjectionComponent {
  static final InjectionComponent _singleton = InjectionComponent._internal();
  static final Injector injector = Injector.appInstance;

  factory InjectionComponent() => _singleton;

  InjectionComponent._internal();

  static Future<void> run() async {
    //Inject all
    injector
    ..registerSingleton<Dio>(() {
      final dio = Dio();
      dio.options.connectTimeout = 325000;
      dio.options.receiveTimeout = 325000;

      if (kDebugMode) {
        dio.interceptors.add(HttpFormatter());
      }

      return dio;
    })

    ..registerSingleton<DataManager>(() => DataManager(injector.get<Dio>())
    );
  }

  static T getDependency<T>() => injector.get<T>();
  
}