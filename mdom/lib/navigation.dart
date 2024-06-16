import 'package:auto_route/auto_route.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/add_device/add_device_web_screen.dart';
import 'package:bpc/screens/claims_filter/claims_filter_web_screen.dart';
import 'package:bpc/screens/payments_filter/payments_filter_web_screen.dart';
import 'package:bpc/screens/period_custom/period_custom_web_screen.dart';
import 'package:bpc/screens/polls_list_filters/polls_list_web_screen.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
/// Simple static class to aggregate navigation
class Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void beforeNavigate() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

  /// Navigate to [AuthScreen]
  static Future<void> toAuth() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(AuthScreen.pageRoute, (route) => false);
  }

  /// Navigate to [ChangePasswordScreen]
  static Future<void> toChangePassword({
    required BuildContext context,
  }) {
    beforeNavigate();
    if (kIsWeb) {
      return Multiplatform.showWebDialog<void>(
        context: context,
        // padding: const EdgeInsets.all(50),
        builder: (context) => const ChangePasswordScreen(),
      );
    } else {
      return Multiplatform.showScrollableDialog<void>(
        context: context,
        builder: (context, scrollController) => ChangePasswordScreen(
          controller: scrollController!,
        ),
      );
    }
  }

  /// Navigate to [ClaimsFiltersScreen]
  static Future<ClaimsFilterData?> toClaimsFilters({
    required BuildContext context,
    required ClaimsFilterData currentFilters,
  }) {
    beforeNavigate();
    if (kIsWeb) {
      return Multiplatform.showWebDialog<ClaimsFilterData>(
        context: context,
        // padding: const EdgeInsets.all(50),
        builder: (context) => ClaimsFilterWebScreen(
          data: currentFilters,
        ),
      );
    } else {
      return Multiplatform.showScrollableDialog<ClaimsFilterData>(
        context: context,
        builder: (context, scrollController) => ClaimsFilterScreen(
          data: currentFilters,
          scrollController: scrollController,
        ),
      );
    }
  }

  /// Navigate to [PaymentsFilterScreen]
  static Future<PaymentsFilterData?> toPaymentsFilters({
    required BuildContext context,
    required PaymentsFilterData currentFilters,
  }) {
    beforeNavigate();
    if (kIsWeb) {
      return Multiplatform.showWebDialog<PaymentsFilterData>(
        context: context,
        builder: (context) => PaymentsFilterWebScreen(
          data: currentFilters,
        ),
      );
    } else {
      return Multiplatform.showScrollableDialog<PaymentsFilterData>(
        context: context,
        builder: (context, scrollController) => PaymentsFilterScreen(
          data: currentFilters,
          scrollController: scrollController,
        ),
      );
    }
  }

  /// Navigate to [PaymentInfoScreen]
  // static Future<void> toPaymentInfo(Payment payment) {
  //   beforeNavigate();
  //   return navigatorKey.currentState!.pushNamed(
  //     PaymentInfoScreen.pageRoute,
  //     arguments: PaymentInfoScreenArgs(
  //       payment: payment,
  //     ),
  //   );
  // }

  /// Navigate to [NewClaimScreen]
  static Future<ClaimsFilterData?> toNewClaim({
    required BuildContext context,
    required Service? initialService,
    required ClaimsFilterData filtersData,
  }) {
    final _dataManager = InjectionComponent.getDependency<DataManager>();

    beforeNavigate();
    if (kIsWeb) {
      return Multiplatform.showWebDialog<ClaimsFilterData>(
        context: context,
        // padding: const EdgeInsets.all(50),
        builder: (context) => NewClaimScreen(
          initialService: initialService,
          servicesList: _dataManager.servicesList,
          filtersData: filtersData,
        ),
      );
    } else {
      return Multiplatform.showScrollableDialog<ClaimsFilterData>(
        context: context,
        builder: (context, scrollController) => NewClaimScreen(
          initialService: initialService,
          servicesList: _dataManager.servicesList,
          filtersData: filtersData,
          // scrollController: scrollController ?? ScrollController(),
        ),
      );
    }
  }

  /// Navigate to [AddDeviceScreen]
  /// add/edit modes are available
  /// for edit - just provide [device] attr
  static Future<Device?> toAddDevice({
    required BuildContext context,
    required Service currentService,
    Device? device,
  }) {
    beforeNavigate();
    if (kIsWeb) {
      return Multiplatform.showWebDialog<Device>(
        context: context,
        builder: (context) => AddDeviceWebScreen(
          itemUnit: currentService.itemUnit!,
          device: device,
        ),
      );
    } else {
      return Multiplatform.showScrollableDialog<Device>(
        context: context,
        // context: Navigation.navigatorKey.currentState.context,
        builder: (context, scrollController) => AddDeviceScreen(
          itemUnit: currentService.itemUnit!,
          device: device,
        ),
      );
    }
  }

  // // Navigate to [ServicesQrScreen]
  // static Future<void> toServicesQr() {
  //   beforeNavigate();
  //   return navigatorKey.currentState!.pushNamedAndRemoveUntil(
  //     ServicesQrScreen.pageRoute,
  //     (route) => false
  //   );
  // }

  /// Navigate to [PollsListFiltersScreen]
  static Future<PollsListFiltersData?> toPollsListFilters({
    required BuildContext context,
    required PollsListFiltersData initialFilters,
  }) {
    beforeNavigate();
    if (kIsWeb) {
      return Multiplatform.showWebDialog<PollsListFiltersData>(
        context: context,
        builder: (context) => PollsListFiltersWebScreen(
          initialFilters: initialFilters,
        ),
      );
    } else {
      return Multiplatform.showScrollableDialog<PollsListFiltersData>(
        context: context,
        builder: (context, scrollController) => PollsListFiltersScreen(
          initialFilters: initialFilters,
        ),
      );
    }
  }

  /// Navigate to [PollAddScreen]
  /// add/edit modes are available
  /// for edit - just provide [poll] attr
  static Future<Poll?> toPollAdd({
    required BuildContext context,
    Poll? poll,
    bool modal = true,
  }) {
    beforeNavigate();
    if (modal) {
      if (kIsWeb) {
        return Multiplatform.showWebDialog<Poll>(
          context: context,
          builder: (context) => PollAddScreen(poll: poll),
        );
      } else {
        return Multiplatform.showScrollableDialog<Poll>(
          context: context,
          builder: (context, scrollController) => PollAddScreen(poll: poll),
        );
      }
    } else {
      return AutoRouter.of(context).push<Poll>(PollAddRoute(poll: poll));
    }
  }

  /// Navigate to [PeriodCustomScreen]
  static Future<MdomPeriodWrapper?> toPeriodCustom({
    required BuildContext context,
    String? title,
    required DateTime? dateFrom,
    required DateTime? dateTo,
  }) {
    beforeNavigate();

    if (kIsWeb) {
      return Multiplatform.showWebDialog<MdomPeriodWrapper>(
        context: context,
        builder: (context) => PeriodCustomWebScreen(
          title: title,
          initialDateFrom: dateFrom,
          initialDateTo: dateTo,
        ),
      );
    } else {
      return Multiplatform.showScrollableDialog<MdomPeriodWrapper>(
        context: context,
        builder: (context, scrollController) => PeriodCustomScreen(
          title: title,
          initialDateFrom: dateFrom,
          initialDateTo: dateTo,
        ),
      );
    }
  }

  /// Navigate to [PollStatisticsQuestionScreen]
  static Future<void> toPollStatisticsQuestion({
    required int pollId,
    required PollListQuestion question,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      PollStatisticsQuestionScreen.pageRoute,
      arguments: PollStatisticsQuestionScreenArgs(
        pollId: pollId,
        question: question,
      ),
    );
  }

  /// Navigate to [PollNotificationScreen]
  static Future<void> toPollNotification({
    required BuildContext context,
    required int id,
  }) {
    beforeNavigate();
    if (kIsWeb) {
      return Multiplatform.showWebDialog<void>(
        context: context,
        builder: (context) => PollNotificationScreen(
          id: id,
        ),
      );
    } else {
      return Multiplatform.showScrollableDialog<void>(
        context: context,
        builder: (context, scrollController) => PollNotificationScreen(
          id: id,
        ),
      );
    }
  }
}
