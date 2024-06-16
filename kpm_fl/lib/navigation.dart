// ignore: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

import 'models/models.dart';
import 'screens/screens.dart';

/// Simple static class to aggregate navigation
mixin Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to [SplashScreen]
  static void toSplash() => navigatorKey.currentState
      ?.pushNamedAndRemoveUntil(SplashScreen.pageRoute, (route) => false);

  /// Navigate to [PopularServicesScreen]
  static void toPopularServices() =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          PopularServicesScreen.pageRoute, (route) => false);

  /// Navigate to [InfoScreen]
  static void toInfo() => navigatorKey.currentState?.pushNamed(
        InfoScreen.pageRoute,
      );

  /// Navigate to [SettingsScreen]
  static void toSettings() =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          SettingsScreen.pageRoute,
          (route) => route.settings.name == InfoScreen.pageRoute);

  /// Navigate to [ServicesScreen]
  static void toServices(int code) =>
      navigatorKey.currentState?.pushNamed(ServicesScreen.pageRoute,
          arguments: ServicesScreenArgs(code: code));

  /// Navigate to [BasketScreen]
  static void toBasket() => navigatorKey.currentState?.pushNamed(
        BasketScreen.pageRoute,
      );

  /// Navigate to [ServiceScreen]
  static void toService(
    int code,
  ) =>
      navigatorKey.currentState?.pushNamed(ServiceScreen.pageRoute,
          arguments: ServiceScreenArgs(
            code: code,
          ));

  /// Navigate to [CheckScreen]
  static void toCheck(
          {required String kioskReceipt, required String barcode}) =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          CheckScreen.pageRoute, (route) => false,
          arguments:
              CheckScreenArgs(kioskReceipt: kioskReceipt, barcode: barcode));
}
