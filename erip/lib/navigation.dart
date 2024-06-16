import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/screens/screens.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ignore: avoid_classes_with_only_static_members
/// Simple static class to aggregate navigation
class Navigation {

  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void beforeNavigate() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

  static void toSplash() {
    beforeNavigate();
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        SplashScreen(),
        // settings: RouteSettings(isInitialRoute: true)
      ),
      (route) => false
    );
  }

  static void toAuth() {
    beforeNavigate();
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        AuthScreen(),
        // settings: RouteSettings(isInitialRoute: true)
      ),
      (route) => false
    );
  }

  static void toHome() {
    beforeNavigate();
    navigatorKey.currentState!.pushReplacement(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<InfoBloc>(
          create: (context) => InfoBloc()..add(InfoInit()),
          child: HomeScreen(),
        )
      )
    );
  }

  static void toAbout() {
    beforeNavigate();
    navigatorKey.currentState!.push(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        AboutScreen(),
      )
    );
  }

  static void toInfo() {
    beforeNavigate();
    navigatorKey.currentState!.push(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        InfoScreen(),
      )
    );
  }

  static void toClaimInfo({
    required Claim claim,
    required Service service,
  }) {
    beforeNavigate();
    navigatorKey.currentState!.push(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<ClaimInfoBloc>(
          create: (context) => ClaimInfoBloc(
            claim: claim,
            service: service
          )..add(ClaimInfoInit()),
          child: ClaimInfoScreen(),
        )
      )
    );
  }

  static void toPaymentInfo(Payment payment) {
    beforeNavigate();
    navigatorKey.currentState!.push(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<PaymentInfoBloc>(
          create: (context) => PaymentInfoBloc(
            payment: payment
          )..add(PaymentInfoInit()),
          child: PaymentInfoScreenNew(),
        )
      )
    );
  }

  static void toServicesQr() {
    beforeNavigate();
    navigatorKey.currentState!.pushReplacement(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<ServicesQrBloc>(
          create: (context) => ServicesQrBloc()..add(ServicesQrInit()),
          child: ServicesQrScreen(),
        )
      )
    );
  }

  static void toSettings() {
    beforeNavigate();
    navigatorKey.currentState!.push(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc()..add(SettingsInit()),
          child: SettingsScreen(),
        )
      )
    );
  }

  static void toClaims() {
    final _dataManager = InjectionComponent.getDependency<DataManager>();

    beforeNavigate();
    navigatorKey.currentState!.pushReplacement(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<ClaimsBloc>(
          create: (context) => ClaimsBloc(),
          child: ClaimsScreen(
            availableFeatures: _dataManager.availableFeatures,
            initialFilters: ClaimsFilterData(
              service: _dataManager.currentService,
              dateFrom: _dataManager.currentDateFrom,
              dateTo: _dataManager.currentDateTo,
              claimsType: 0
            ),
          ),
        )
      )
    );
  }

  static void toPayments() {
    final _dataManager = InjectionComponent.getDependency<DataManager>();

    beforeNavigate();
    navigatorKey.currentState!.pushReplacement(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<PaymentsBloc>(
          create: (context) => PaymentsBloc(),
          child: PaymentsScreen(
            availableFeatures: _dataManager.availableFeatures,
            initialFilters: PaymentsFilterData(
              service: _dataManager.currentService,
              dateType: 0,
              dateFrom: _dataManager.currentDateFrom,
              dateTo: _dataManager.currentDateTo,
              paymentsType: 0
            ),
          ),
        )
      )
    );
  }

  static void toClaimPayments(ClaimPaymentsData info) {
    beforeNavigate();
    navigatorKey.currentState!.push(
      MaterialWithModalsPageRoute<void>(builder: (context) =>
        BlocProvider<PaymentsBloc>(
          create: (context) => PaymentsBloc(
            savefilters: false
          ),
          child: ClaimPaymentsScreen(info)
        )
      )
    );
  }

  static void toNewClaim({
    required BuildContext context,
    required ClaimsBloc bloc,
    required Service? initialService
  }) {
    final _dataManager = InjectionComponent.getDependency<DataManager>();

    beforeNavigate();
    Multiplatform.showScrollableDialog<ClaimsFilterData>(
      context: context,
      builder: (context, scrollController) => NewClaimScreen(
        bloc: bloc,
        initialService: initialService,
        servicesList: _dataManager.servicesList,
        scrollController: scrollController,
      )
    );
  }

  static Future<String?> toQrCam({
    required DateTime initialDateFrom
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.push<String>(
      MaterialWithModalsPageRoute<String>(builder: (context) =>
        BlocProvider<ClaimQrBloc>(
          create: (_) => ClaimQrBloc(),
          child: QrCamScreen(
            initialDateFrom: initialDateFrom,
          ),
        )
      )
    );
  }
      
}