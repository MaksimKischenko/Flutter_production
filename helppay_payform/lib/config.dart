import 'package:helppay_payform_app/utils/utils.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static const String appName = 'HelpPay payform';

  static String passwordCrypter(String value) => value.toSha256();

  // cmd args

  // static const String apiUrl = String.fromEnvironment('apiUrl',
  //     defaultValue: 'http://192.168.249.58:8085/helppay_payform');


  // cmd args END

  static int defaultCurrency = 933;

  // currency code to name
  static Map<int, String> mapCurrencyToName = const {
    933: 'BYN',
    860: 'UZS'
  };

  // default GPL filter 'name' id
  static const int filterNameId = 315;

  static const int diTypeNode = 9120;
  static const int diTypeService = 9191;
 
}