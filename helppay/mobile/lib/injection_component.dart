// import 'package:alice/alice.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:injector/injector.dart';

class InjectionComponent {
  static final InjectionComponent _singleton = InjectionComponent._internal();
  // Use this static instance
  static final Injector injector = Injector.appInstance;

  factory InjectionComponent() => _singleton;

  InjectionComponent._internal();

  static Future<void> run() async {
    //Inject all
    // injector.registerSingleton<Alice>(() => Alice(showNotification: true, showInspectorOnShake: true, darkTheme: true));
    // injector..registerSingleton<Logger>(() => Logger())

    injector
      ..registerSingleton<Dio>(() {
        // var logger = injector.get<Logger>();
        // var alice = injector.get<Alice>();
        // alice.setNavigatorKey(Navigation.navigatorKey);

        final dio = Dio();
        if (!kIsWeb) {
          (dio.httpClientAdapter as IOHttpClientAdapter)
                  .onHttpClientCreate = //TODO this soon will be deprecated so its neeed to be changed to proper way of intaraction
              (HttpClient client) {
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
            return client;
          };
        }
        dio.options.connectTimeout = const Duration(milliseconds: 150000);
        dio.options.receiveTimeout = const Duration(milliseconds: 150000);

        // dio.interceptors.add(
        //   PrettyDioLogger(
        //     requestHeader: true,
        //     requestBody: true,
        //     responseBody: true,
        //     responseHeader: false,
        //     error: true,
        //     compact: false,
        //     // maxWidth: 9
        //   )
        // );

        // dio.interceptors.add(InterceptorsWrapper(
        //   onRequest: (RequestOptions options) async {
        //     logger.i(options.uri);
        //     logger.i(options.data);
        //     return options;
        //   },
        //   onResponse: (Response response) async {
        //     logger.i(response.data);
        //     return response;
        //   },
        //   onError: (DioError e) async {
        //     logger.e(e.message);
        //     return e;
        //   }
        // ));

        dio.interceptors.add(HttpFormatter());

        // dio.interceptors.add(alice.getDioInterceptor());

        return dio;
      })
      ..registerSingleton<DataManager>(() {
        final dio = injector.get<Dio>();
        return RealDataManager(dio);
        // return FakeDataManager(dio);
      });

    // injector.registerSingleton<PreferencesHelper>((_) => PreferencesHelper());
  }

  static T getDependency<T>() => injector.get<T>();
}
