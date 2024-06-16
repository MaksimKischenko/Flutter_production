
mixin AppConfig {
  static const String appName = 'QR module';

  static String komplatApiUrl = const String.fromEnvironment('komplatApiUrl',
      defaultValue: 'https://qrpay.mdom.by');
  static const komplatQrApiUrl = String.fromEnvironment('komplatQrApiUrl',
      defaultValue: 'https://qrhelppay.mdom.by');

  static const defaultLanguageName = 'ru';
  static const isDebugMode = false;

}

