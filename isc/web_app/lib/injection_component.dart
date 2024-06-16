// import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:injector/injector.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/data/real_data_manager.dart';

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
        dio.options.connectTimeout = const Duration(milliseconds: 25000);
        dio.options.receiveTimeout = const Duration(milliseconds: 25000);

        dio.interceptors.add(HttpFormatter());


        return dio;
      })
      ..registerSingleton<DataManager>(() {
        final dio = injector.get<Dio>();
        return RealDataManager(dio);
        //return FakeDataManager(dio);
      });

  }

  static T getDependency<T>() => injector.get<T>();
}
