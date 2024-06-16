// ignore: avoid_classes_with_only_static_members
class AppConfig {

  // from cmd  
  static const deviceType = String.fromEnvironment('deviceType', defaultValue: 'MBCab');

  // Base URLs should always end in /.
  static const komplatApiUrl = String.fromEnvironment('komplatApiUrl', defaultValue: 'https://lkpu.raschet.by/kp_tpayer_o');

  static const String? defaultLogin = bool.hasEnvironment('defaultLogin')
    ? String.fromEnvironment('defaultLogin')
    : null;
  static const String? defaultPassword = bool.hasEnvironment('defaultPassword')
    ? String.fromEnvironment('defaultPassword')
    : null;

  
  // about

  static final copyright = '© ${DateTime.now().year} ОАО "НКФО "ЕРИП"';
  static const organizationSiteTitle = 'www.raschet.by';
  static const organizationSiteUrl = 'https://raschet.by/';
  static const contactEmail = 'info@raschet.by';
}