// ignore: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/data/remote_models/komplat_general_elements.dart';

import 'models/models.dart';
import 'screens/screens.dart';

/// Simple static class to aggregate navigation
mixin Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to [SplashScreen]
  static void toSplash() => navigatorKey.currentState
      ?.pushNamedAndRemoveUntil(SplashScreen.pageRoute, (route) => false);

  /// Navigate to [PaymentsScreen]
  static void toPayments() => navigatorKey.currentState
      ?.pushNamedAndRemoveUntil(PaymentsScreen.pageRoute, (route) => false);

  /// Navigate to [PopularServicesScreen]
  static void toPopularServices() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        PopularServicesScreen.pageRoute, (route) => false);
  }

  // Navigate to [AllServicesScreen]
  // static void toAllServices() => navigatorKey.currentState?.pushNamedAndRemoveUntil(
  //   AllServicesScreen.pageRoute,
  //   (route) => false
  // );

  /// Navigate to [InitHelppayServicesScreen]
  static void toInitHelppayServices(
          {Service? node, int? nodeId, int? nodeType}) =>
      navigatorKey.currentState?.pushNamed(
        InitHelppayServicesScreen.pageRoute,
        arguments: NodeScreenParams(
          node: node,
          nodeId: nodeId,
          nodeType: nodeType,
        ),
      );

  /// Navigate to [ServicesScreen]
  static void toServices(int code, int diType) => navigatorKey.currentState
      ?.pushNamed('${ServicesScreen.pageRoute}?code=$code&diType=$diType');

  /// Navigate to [ServiceScreen]
  static void toService(int code, int diType, String name) =>
      navigatorKey.currentState?.pushNamed(
          '${ServiceScreen.pageRoute}?code=$code&diType=$diType&name=$name');

  /// Navigate to [ServiceScreen]
  static void toServiceWithSuplierName(
          int code, int diType, String name, String suplierName) =>
      navigatorKey.currentState?.pushNamed(
          '${ServiceScreen.pageRoute}?code=$code&diType=$diType&name=$name&suplierName=$suplierName');

  /// Navigate to [CheckScreen]
  static void toCheck(
          {required int paymentId,
          AttrRecordResponse? suplierName,
          AttrRecordResponse? suplierValueName,
          List<String>? checkList,
          int? code,
          String? name,
          bool removeBefore = true}) =>
      removeBefore
          ? navigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/check?id=$paymentId', (route) => false,
              arguments: CheckScreenParams(
                  suplierValueName: suplierValueName!,
                  suplierName: suplierName!,
                  checkList: checkList,
                  code: code ?? 0,
                  name: name ?? ''))
          : navigatorKey.currentState?.pushNamed('/check?id=$paymentId',
              arguments: CheckScreenParams(
                  suplierValueName: suplierValueName!,
                  suplierName: suplierName!,
                  checkList: checkList,
                  code: code ?? 0,
                  name: name ?? ''));
}
