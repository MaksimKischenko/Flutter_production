
// ignore: avoid_classes_with_only_static_members
import 'package:helppay_core/config.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_web_app/models/models.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static const String appName = 'Платежное приложение web версия';


  static bool isUrlHashStrategy = true;

  static String urlAppend = '';

  static const int refreshTime  = 180;

    static MenuTab defaultMenuTab = CoreConfig.appFlavour == AppFlavour.full
      ? MenuTab.accruals
      : MenuTab.products;
} 