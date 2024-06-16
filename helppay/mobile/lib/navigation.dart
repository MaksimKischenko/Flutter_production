import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/screens/mdom_account_info_payments_screen/mdom_account_info_payments_screen.dart';
import 'package:helppay/screens/mdom_account_service_statistics.dart/mdom_account_service_statistics.dart';
import 'package:helppay/screens/mdom_company_search/mdom_company_search_screen.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/helppay_core.dart';

import 'blocs/blocs.dart';
import 'injection_component.dart';
import 'screens/auth_change_password_screen/auth_change_password_screen.dart';
import 'screens/screens.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'navigation');

// ignore: avoid_classes_with_only_static_members
/// Simple static class to aggregate navigation
class Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void beforeNavigate() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

  /// Navigate to [SplashScreen]
  static Future<void> toSplash() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(SplashScreen.pageRoute, (route) => false);
  }

  /// Navigate to [AuthScreen]
  static Future<void> toAuth() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(AuthScreen.pageRoute, (route) => false);
  }

  /// Navigate to [MainScreen]
  static Future<void> toMain() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(MainScreen.pageRoute, (route) => false);
  }

  /// Navigate to [RegistrationScreen]
  static Future<void> toRegistration() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(RegistrationScreen.pageRoute);
  }

  /// Navigate to [WebViewScreen]
  static Future<void> toWebViewScreen() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(WebViewScreen.pageRoute);
  }

  /// Navigate to [CardCreationScreen]
  static Future<void> toCardCreationScreenScreen() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(CardCreationScreen.pageRoute);
  }

  /// Navigate to [RegistrationParamsScreen]
  static Future<void> toRegistrationParams({
    required List<MdomResponseParam> params,
    List<MdomLookupItem>? lookUps,
    String? phoneNumber,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      RegistrationParamsScreen.pageRoute,
      (route) => false,
      arguments: RegistrationParamsScreenArgs(
        params: params,
        lookUps: lookUps,
        phone: phoneNumber,
      ),
    );
  }

  /// Navigate to [RegistrationCodeScreen]
  static Future<void> toRegistrationCode({required ConfirmCodeType codeType}) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      RegistrationCodeScreen.pageRoute,
      (route) => false,
      arguments: RegistrationCodeScreenArgs(codeType: codeType),
    );
  }

  /// Navigate to [RegistrationSuccessScreen]
  static Future<void> toRegistrationSuccess() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        RegistrationSuccessScreen.pageRoute, (route) => false);
  }

  /// Navigate to [SettingsScreen]
  static Future<void> toSettings() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      SettingsScreen.pageRoute,
    );
  }

  /// Navigate to [ProfileScreen]
  static Future<void> toProfile({
    required BuildContext context,
    bool modal = false,
  }) {
    beforeNavigate();
    if (modal) {
      return Multiplatform.showScrollableDialog<void>(
        context: context,
        builder: (context, scrollController) => const ProfileScreen(),
      );
    } else {
      return navigatorKey.currentState!.pushNamed(
        ProfileScreen.pageRoute,
        arguments: const ProfileScreen(),
      );
    }
  }

  /// Navigate to [ProfileEditScreen]
  static Future<void> toProfileEdit({
    required List<MdomResponseParam> userParams,
    MdomLookup? lookups,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      ProfileEditScreen.pageRoute,
      arguments:
          ProfileEditScreenArgs(userParams: userParams, lookups: lookups),
    );
  }

  /// Navigate to [QrHistoryScreen]
  static Future<void> toQrHistoryScreen() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      QrHistoryScreen.pageRoute,
      // arguments: QrPaymentsHistoryScreenArgs(),
    );
  }

  /// Navigate to [PaymentsHistoryFiltersScreen]
  static Future<PaymentsHistoryFiltersScreenArgs?> toPaymentsHistoryFilters({
    required BuildContext context,
    required PaymentsHistoryFiltersScreenArgs? data,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<PaymentsHistoryFiltersScreenArgs>(
      context: context,
      builder: (context, scrollController) => PaymentsHistoryFiltersScreen(
        data: data,
        scrollController: scrollController,
      ),
    );
  }

  /// Navigate to [ChangePasswordScreen]
  static Future<void> toChangePassword({
    required BuildContext context,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => BlocProvider<ChangePasswordBloc>(
        create: (context) => ChangePasswordBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        )..add(ChangePasswordInit()),
        child: ChangePasswordScreen(
          controller: scrollController,
        ),
      ),
    );
  }

  /// Navigate to [NotificationMethodScreen]
  static Future<String?> toNotificationMethod(
      {required BuildContext context,
      required String? currentNotificationMethodName}) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<String>(
      context: context,
      builder: (context, scrollController) => NotificationMethodScreen(
        currentNotificationMethodName: currentNotificationMethodName,
      ),
    );
  }

  /// Navigate to [ProductAddScreen]
  static Future<void> toProductAdd({
    required BuildContext context,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => ProductAddScreen(
        scrollController: scrollController,
      ),
    );
  }

  /// Navigate to [CardInfoScreen]
  static Future<void> toCardInfo({
    required BuildContext context,
    required MdomLoginResponseProductsCurrent card,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => CardInfoScreen(
        card: card,
      ),
    );
  }

  /// Navigate to [BnbCardAddScreen]
  // static Future<void> toBNBCardAdd() {
  //   beforeNavigate();
  //   return navigatorKey.currentState!
  //       .pushNamed(BnbCardAddScreen.pageRoute);
  // }

  /// Navigate to [AccountInfoScreen]
  static Future<void> toAccountInfo({
    required BuildContext context,
    required MdomLoginResponseProductsCurrent account,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => AccountInfoScreen(
        account: account,
      ),
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

  /// Navigate to [MdomAccrualsScreen]
  static Future<void> toMdomAccruals() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        MdomAccrualsScreen.pageRoute, (route) => false);
  }

  /// Navigate to [MdomChangePasswordScreen]
  static Future<void> toAuthChangePasswordScreen() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      AuthChangePasswordScreen.pageRoute,
    );
  }

  /// Navigate to [MdomAccountAddScreen]
  static Future<void> toMdomAccountAdd({
    required BuildContext context,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => MultiBlocProvider(
        providers: [
          BlocProvider<MdomCreateAccountBloc>(
            create: (context) => MdomCreateAccountBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider<InfoSupplierBloc>(
            create: (context) => InfoSupplierBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
        ],
        child: const MdomAccountAddScreen(),
      ),
    );
  }

  /// Navigate to [MdomCompanyChoiceScreen]
  static Future<CompaniesResponseCompany?> toMdomCompanyChoise({
    required BuildContext context,
    required List<CompaniesResponseCompany> companies,
    required int? initialCompanyId,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<CompaniesResponseCompany>(
      context: context,
      builder: (context, scrollController) => MdomCompanyChoiceScreen(
        companies: companies,
        initialCompanyId: initialCompanyId,
      ),
    );
  }

  /// Navigate to [MdomCompanySearchScreen]
  static Future<InfoSupplierResponseCompany?> toMdomCompanySearch({
    required BuildContext context,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<InfoSupplierResponseCompany>(
      context: context,
      builder: (context, scrollController) => BlocProvider<InfoSupplierBloc>(
        create: (context) => InfoSupplierBloc(
            dataManager: InjectionComponent.getDependency<DataManager>()),
        child: const MdomCompanySearchScreen(),
      ),
    );
  }

  /// Navigate to [MdomPeriodScreen]
  static Future<MdomPeriodWrapper?> toMdomPeriod({
    required BuildContext context,
    required MdomPeriodWrapper period,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<MdomPeriodWrapper>(
      context: context,
      builder: (context, scrollController) => MdomPeriodScreen(
        periodWrapper: period,
      ),
    );
  }

  /// Navigate to [MdomPeriodCustomScreen]
  static Future<MdomPeriodWrapper?> toMdomPeriodCustom({
    required BuildContext context,
    String? title,
    required DateTime? dateFrom,
    required DateTime? dateTo,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<MdomPeriodWrapper>(
      context: context,
      builder: (context, scrollController) => MdomPeriodCustomScreen(
        title: title,
        initialDateFrom: dateFrom,
        initialDateTo: dateTo,
      ),
    );
  }

  /// Navigate to [MdomAccountInfo]
  static Future<void> toMdomAccountInfo({
    required BuildContext context,
    required int supplierId,
    required PropertyAccount account,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => BlocProvider<MdomAccountInfoBloc>(
        create: (context) => MdomAccountInfoBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
          supplierId: supplierId,
          account: account.account!.evalue,
        ),
        child: MdomAccountInfo(
          account: account,
        ),
      ),
    );
  }

  static Future<void> toMdomAccountServiceStatistics({
    required BuildContext context,
    required List<PaymentBilling> payments,
    required List<MdomService> services,
    required MdomAccountInfoLoaded state,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => MdomAccountServiceStatistics(
        payments: payments,
        services: services,
        state: state,
      ),
    );
  }

  /// Navigate to [MdomAccountInfoPaymentsScreen]
  static Future<void> toMdomAccountInfoPaymentScreen({
    required BuildContext context,
    required List<PaymentBilling> paymentsList,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => MdomAccountInfoPaymentsScreen(
        paymentsList: paymentsList,
      ),
    );
  }

  /// Navigate to [MdomServiceInfo]
  static Future<void> toMdomServiceInfo({
    required BuildContext context,
    required MdomService service,
    required List<MdomService> services,
    required List<PaymentBilling> payments,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<void>(
      context: context,
      builder: (context, scrollController) => MdomServiceInfo(
        service: service,
        services: services,
        payments: payments,
      ),
    );
  }

  /// Navigate to [MdomNotificationsScreen]
  static Future<dynamic> toMdomNotifications({
    required int supplierId,
    required String supplierTitle,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamed<dynamic>(MdomNotificationsScreen.pageRoute,
            arguments: MdomNotificationsListScreenArgs(
              supplierId: supplierId,
              suppierTitle: supplierTitle,
              //accountsCount: accountsCount
            ));
  }

  /// Navigate to [SelectLanguageScreen]
  static Future<AppLocale?> toSelectLanguage({
    required BuildContext context,
    bool modal = false,
  }) {
    beforeNavigate();
    if (modal) {
      return Multiplatform.showScrollableDialog<AppLocale>(
          context: context,
          builder: (context, scrollController) => const SelectLanguageScreen());
    } else {
      return navigatorKey.currentState!.pushNamed<AppLocale>(
        SelectLanguageScreen.pageRoute,
        arguments: const SelectLanguageScreen(),
      );
    }
  }

  /// Navigate to [MdomPollsListScreen]
  static Future<void> toMdomPollsList({
    required int supplierId,
    required int accountsCount,
    required String supplierTitle,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      MdomPollsListScreen.pageRoute,
      arguments: MdomPollsListScreenArgs(
        supplierId: supplierId,
        accountsCount: accountsCount,
        supplierTitle: supplierTitle,
      ),
    );
  }

  /// Navigate to [MdomPollsListFiltersScreen]
  static Future<PollsListFiltersData?> toMdomPollsListFilters({
    required BuildContext context,
    required PollsListFiltersData initialFilters,
  }) {
    beforeNavigate();
    return Multiplatform.showScrollableDialog<PollsListFiltersData>(
      context: context,
      builder: (context, scrollController) => MdomPollsListFiltersScreen(
        initialFilters: initialFilters,
      ),
    );
  }

  /// Navigate to [MdomPollScreen]
  static Future<Poll?> toMdomPoll({
    required int participantsCount,
    required Poll poll,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed<Poll>(
      MdomPollScreen.pageRoute,
      arguments: MdomPollScreenArgs(
        participantsCount: participantsCount,
        poll: poll,
      ),
    );
  }

  /// Navigate to [MdomPollStatisticsScreen]
  static Future<void> toMdomPollStatistics({
    required int participantsCount,
    required Poll poll,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      MdomPollStatisticsScreen.pageRoute,
      arguments: MdomPollStatisticsScreenArgs(
        participantsCount: participantsCount,
        poll: poll,
      ),
    );
  }

  /// Navigate to [MdomPollStatisticsQuestionScreen]
  static Future<void> toMdomPollStatisticsQuestion({
    required int pollId,
    required PollListQuestion question,
  }) {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamed(
      MdomPollStatisticsQuestionScreen.pageRoute,
      arguments: MdomPollStatisticsQuestionScreenArgs(
        pollId: pollId,
        question: question,
      ),
    );
  }
}
