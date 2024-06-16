import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static const String appName = 'Мой Дом';

  // cmd args
  static const deviceType = String.fromEnvironment('deviceType', defaultValue: 'MB');

  // Base URLs should always end in /.
  static const showFakeDeviceFrame = bool.fromEnvironment('showFakeDeviceFrame');
  static const komplatApiUrl = String.fromEnvironment('komplatApiUrl', defaultValue: 'https://mobile.mdom.by');
  static const mdomApiUrl = String.fromEnvironment('mdomApiUrl', defaultValue: 'https://users.mdom.by');
  static const mdomTpIntApi = String.fromEnvironment('mdomTpIntApi', defaultValue: 'https://vote.mdom.by');


  static const String? defaultLogin = bool.hasEnvironment('defaultLogin')
    ? String.fromEnvironment('defaultLogin')
    : null;
  static const String? defaultPassword = bool.hasEnvironment('defaultPassword')
    ? String.fromEnvironment('defaultPassword')
    : null;
  
  // cmd args END

  static String passwordCrypter(String value) => value.toSha256();

  static MenuTab defaultMenuTab = MenuTab.more;

  // load count

  static const int claimsListLoadCount = 20;

  static const int paymentsListLoadCount = 20;

  static const int pollsListRequestLoadCount = 10;
  
  // about

  static final copyright = '© ${DateTime.now().year} ООО «РАСВИКОМ СЕРВИС»';
  static const organizationSiteTitle = 'www.mdom.by';
  static const organizationSiteUrl = 'https://mdom.by/';
  static const contactEmail = 'info@mdom.by';
}