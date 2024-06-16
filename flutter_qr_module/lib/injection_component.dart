import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:injector/injector.dart';

class InjectionComponent {
  static final InjectionComponent _singleton = InjectionComponent._internal();
  // Use this static instance
  static final Injector injector = Injector.appInstance;

  factory InjectionComponent() => _singleton;

  InjectionComponent._internal();

  static Future<void> run() async {
    injector
      ..registerSingleton<Dio>(() {
        final dio = Dio();
          (dio.httpClientAdapter as IOHttpClientAdapter)
              // ignore: deprecated_member_use
              .onHttpClientCreate = (HttpClient client) {
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
            return client;
          };
        dio.options.connectTimeout = const Duration(milliseconds: 150000);
        dio.options.receiveTimeout = const Duration(milliseconds: 150000);
        dio.interceptors.add(HttpFormatter());

        return dio;
      })
      ..registerSingleton<DataManager>(() {
        final dio = injector.get<Dio>();
        return RealDataManager(dio);
      });
  }

  static T getDependency<T>() => injector.get<T>();
}
