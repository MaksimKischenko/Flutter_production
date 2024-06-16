import 'package:isc_web_app/utils/string_helper.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static const String appName = 'Платежное приложение';

  static bool isUrlHashStrategy = true;

  static String urlAppend = '';

  static const int refreshTime  = 180;

  static const String? defaultLogin = bool.hasEnvironment('defaultLogin')
      ? String.fromEnvironment('defaultLogin')
      : null;
  static const String? defaultPassword = bool.hasEnvironment('defaultPassword')
      ? String.fromEnvironment('defaultPassword')
      : null;

  static const komplatISCApi = String.fromEnvironment('komplatISCApi', defaultValue: '');

  static String passwordCrypter(String value) => value.toSha256();

  static const int paymentsListRequestLoadCount = 10;

  static const int claimsListRequestLoadCount = 10;

  static const defaultLanguageName = 'ru';

  static const currency = 'BYN';
} 