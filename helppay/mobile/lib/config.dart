// ignore_for_file: avoid_classes_with_only_static_members

import 'package:helppay_core/helppay_core.dart';

import 'models/models.dart';

class AppConfig {
  // cmd args

  static const bool showFakeDeviceFrame =
      bool.fromEnvironment('showFakeDeviceFrame');

  // cmd args END

  static MenuTab defaultMenuTab = CoreConfig.appFlavour == AppFlavour.full
      ? MenuTab.paymentQr
      : MenuTab.accruals;

  static int rowCountNotification = 10;

  static int refreshTime = 1;
}
