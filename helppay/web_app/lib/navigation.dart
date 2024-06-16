import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/screens/mdom_account_info_payments_screen/mdom_account_info_payments_screen.dart';
import 'package:helppay_web_app/screens/mdom_company_search/mdom_company_search_screen.dart';

import 'screens/screens.dart';
import 'utils/utils.dart';

// ignore: avoid_classes_with_only_static_members
class Navigation {
  static Future<CompaniesResponseCompany?> toMdomCompanyChoise({
    required BuildContext context,
    required List<CompaniesResponseCompany> companies,
    required int? initialCompanyId,
  }) =>
      Multiplatform.showWebDialog<CompaniesResponseCompany>(
        context: context,
        builder: (context) => MdomCompanyChoiceScreen(
          companies: companies,
          initialCompanyId: initialCompanyId,
        ),
      );

  static Future<InfoSupplierResponseCompany?> toMdomCompanySearch({
    required BuildContext context,
  }) =>
      Multiplatform.showWebDialog<InfoSupplierResponseCompany>(
        context: context,
        builder: (context) => BlocProvider<InfoSupplierBloc>(
          create: (context) => InfoSupplierBloc(
              dataManager: InjectionComponent.getDependency<DataManager>()),
          child: const MdomCompanySearchScreen(),
        ),
      );

  static Future<MdomPeriodWrapper?> toMdomPeriod({
    required BuildContext context,
    required MdomPeriodWrapper period,
  }) =>
      Multiplatform.showWebDialog<MdomPeriodWrapper>(
        context: context,
        builder: (context) => MdomPeriodScreen(
          periodWrapper: period,
        ),
      );

  static Future<MdomPeriodWrapper?> toMdomPollStatisticsScreen({
    required BuildContext context,
    int? participantsCount,
    Poll? poll,
  }) =>
      Multiplatform.showWebDialog<MdomPeriodWrapper>(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 5,
            vertical: MediaQuery.of(context).size.height / 9),
        context: context,
        builder: (context) => MdomPollStatisticsScreen(
          participantsCount: participantsCount,
          poll: poll,
        ),
      );

  static Future<MdomPeriodWrapper?> toMdomQuestionScreenScreen({
    required BuildContext context,
    int? pollId,
    PollListQuestion? question,
  }) =>
      Multiplatform.showWebDialog<MdomPeriodWrapper>(
        context: context,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 5,
            vertical: MediaQuery.of(context).size.height / 9),
        builder: (context) => MdomPollStatisticsQuestionScreen(
          pollId: pollId,
          question: question,
        ),
      );

  static Future<PaymentsHistoryFiltersScreenArgs?> toPaymentHistory({
    required BuildContext context,
    required PaymentsHistoryFiltersScreenArgs? data,
  }) =>
      Multiplatform.showWebDialog<PaymentsHistoryFiltersScreenArgs>(
        context: context,
        builder: (context) => PaymentsHistoryFiltersScreen(
          data: data,
        ),
      );

  static Future<MdomPeriodWrapper?> toMdomAccountAdd({
    required BuildContext context,
  }) =>
      Multiplatform.showWebDialog<MdomPeriodWrapper>(
        context: context,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3.3,
            vertical: MediaQuery.of(context).size.height / 5),
        builder: (context) => const MdomAccountAddScreen(),
      );

  static Future<MdomPeriodWrapper?> toProfileEditScreen({
    required BuildContext context,
    final List<MdomResponseParam>? params,
    MdomLookup? lookups,
  }) =>
      Multiplatform.showWebDialog<MdomPeriodWrapper>(
        context: context,
        builder: (context) => ProfileEditScreen(
          params: params,
          lookups: lookups,
        ),
      );

  static Future<void> toMdomNotificationList({
    required BuildContext context,
    required int supplierId,
    required String supplierTitle,
  }) =>
      Multiplatform.showWebDialog<void>(
        context: context,
        builder: (context) => MdomNotificationsScreen(
          supplierId: supplierId,
          supplierTitle: supplierTitle,
        ),
      );

  static Future<MdomPeriodWrapper?> toMdomPeriodCustom({
    required BuildContext context,
    String? title,
    required DateTime? dateFrom,
    required DateTime? dateTo,
  }) =>
      Multiplatform.showWebDialog<MdomPeriodWrapper>(
        context: context,
        builder: (context) => MdomPeriodCustomScreen(
          title: title,
          initialDateFrom: dateFrom,
          initialDateTo: dateTo,
        ),
      );

  static Future<MdomPeriodWrapper?> toChangePassword({
    required BuildContext context,
  }) =>
      Multiplatform.showWebDialog<MdomPeriodWrapper>(
        context: context,
        builder: (context) => const ChangePasswordScreen(),
      );

  static Future<void> toMdomAccountInfoPaymentScreen({
    required BuildContext context,
    required List<PaymentBilling> paymentsList,
  }) =>
      Multiplatform.showWebDialog<void>(
        context: context,
        builder: (context) => MdomAccountInfoPaymentsScreen(
          paymentsList: paymentsList,
        ),
      );

  static Future<void> toMdomServiceInfo({
    required BuildContext context,
    required MdomService service,
    required List<MdomService> services,
    required List<PaymentBilling> payments,
  }) =>
      Multiplatform.showWebDialog<void>(
        context: context,
        builder: (context) => MdomServiceInfo(
          service: service,
          services: services,
          payments: payments,
        ),
      );

  static Future<AppLocale?> toSelectLanguage({
    required BuildContext context,
  }) =>
      Multiplatform.showWebDialog<AppLocale>(
        context: context,
        builder: (context) => const SelectLanguageScreen(),
      );

  static Future<String?> toSelectNotificationMethod(
          {required BuildContext context,
          required String currentNotificationMethodName}) =>
      Multiplatform.showWebDialog<String>(
        context: context,
        builder: (context) => SelectNotificationMethodScreen(
            currentNotificationMethodName: currentNotificationMethodName),
      );

  static Future<void> toEditAccountNameScreen(
          {required BuildContext context,
          required String? pan,
          required MdomResponseParam? param}) =>
      Multiplatform.showWebDialog<void>(
        context: context,
        builder: (context) => EditAccountNameScreen(
          pan: pan,
          nameParam: param,
        ),
      );

  static Future<void> toEditCardNameScreen(
          {required BuildContext context,
          required String? pan,
          required MdomResponseParam? param}) =>
      Multiplatform.showWebDialog<void>(
        context: context,
        builder: (context) => EditCardNameScreen(
          pan: pan,
          nameParam: param,
        ),
      );
}
