// ignore_for_file: avoid_classes_with_only_static_members

import 'package:helppay_core/helppay_core.dart';

class CoreConfig {
  static const String appName = 'HelpPay';

  // cmd args

  static const String? defaultLogin = bool.hasEnvironment('defaultLogin')
      ? String.fromEnvironment('defaultLogin')
      : null;
  static const String? defaultPassword = bool.hasEnvironment('defaultPassword')
      ? String.fromEnvironment('defaultPassword')
      : null;

  static AppFlavour appFlavour =
      //AppFlavourExtension.fromName(const String.fromEnvironment('appFlavour'));
      AppFlavourExtension.fromName('full');

  static const komplatApiUrl = String.fromEnvironment('komplatApiUrl',
      defaultValue: 'https://qrpay.mdom.by/'); //https://mobile.mdom.by
  static const komplatQrApiUrl = String.fromEnvironment('komplatQrApiUrl',
      defaultValue: 'https://qrhelppay.mdom.by');
  static const mdomApiUrl = String.fromEnvironment('mdomApiUrl',
      defaultValue: 'https://users.mdom.by');
  static const mdomTpIntApi = String.fromEnvironment('mdomTpIntApi',
      defaultValue: 'https://vote.mdom.by');
  static const mdomTpInfoApi = String.fromEnvironment('mdomTpInfoApi',
      defaultValue: 'https://users.mdom.by');
// static const komplatApiUrl = String.fromEnvironment('komplatApiUrl',
//       defaultValue:'http://192.168.244.104:7788/komplat');
//   static const komplatQrApiUrl = String.fromEnvironment('komplatQrApiUrl',
//       defaultValue: 'https://qrhelppay.mdom.by');
//   static const mdomApiUrl = String.fromEnvironment('mdomApiUrl',
//       defaultValue: 'http://192.168.244.126:8085/mdom_user');
//   static const mdomTpIntApi = String.fromEnvironment('mdomTpIntApi',
//       defaultValue: 'https://vote.mdom.by');
//   static const mdomTpInfoApi = String.fromEnvironment('mdomTpInfoApi',
//       defaultValue: 'http://192.168.244.126:8085/mdom_user');

  static String passwordCrypter(String value) => value.toSha256();

  static const int getOperationHistoryRequestLoadCount = 10;

  static const int pollsListRequestLoadCount = 20;

  static const int notificationsListRequestLoadCount = 20;

  static const defaultLanguageName = 'ru';

  static Future<String?> defaultNotification() async =>
      await PreferencesHelper.read(PrefsKeys.notificationMethod);

  static const currency = 'BYN';
}
