import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'injection_component.dart';
import 'screens/screens.dart';

mixin Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void beforeNavigate() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

    /// Navigate to [NativeHostSplashScreen]
  static Future<void> toNativeHostSplash() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(NativeHostSplashScreen.pageRoute, (route) => false);
  }

  /// Navigate to [MainScreen]
  static Future<void> toMain() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(MainScreen.pageRoute, (route) => false);
  }


  /// Navigate to [QrHistoryScreen]
  static Future<void> toQrHistoryScreen() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      QrHistoryScreen.pageRoute,
      // arguments: QrPaymentsHistoryScreenArgs(),
    );
  }



  /// Navigate to [PaymentScreen]
  static Future<bool?> toPayment({
    required BuildContext context,
    required QrEripData data,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<bool>(
      context: context,
      builder: (context, controller) => BlocProvider<PaymentBloc>(
        create: (context) => PaymentBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        )..add(PaymentGetInfo(data)),
        child: PaymentScreen(
          data: data,
          scrollController: controller,
        ),
      ),
    );
  }

  /// Navigate to [QrScanScreen]
  static Future<QrEripData?> toQrScan({
    required BuildContext context,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<QrEripData>(
      context: context,
      builder: (context, scrollController) => BlocProvider<QrCamBloc>(
        create: (context) => QrCamBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        )..add(QrCamPermissionCheck()),
        child: const QrScanScreen(),
      ),
    );
  }

}
