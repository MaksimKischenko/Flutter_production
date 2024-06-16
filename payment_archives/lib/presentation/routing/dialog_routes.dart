import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/screens/payments/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/screens/screens.dart';
import 'package:payment_tracking_module/utils/utils.dart';

mixin DialogRoutes {
  static Future<SearchPaymentData?> toRequestFilters({
    required BuildContext context,
  }) =>
    DialogPlatform.showScreenDialog<SearchPaymentData>(
      context: context,
      builder: (context) => const PaymentsFiltersScreen(),
  );

  static Future<AuditLogSearchFiltersData?> toChangePasswordScreen({
    required BuildContext context}) =>
  DialogPlatform.showScreenDialog(
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4, vertical: MediaQuery.of(context).size.height / 3.5),
    context: context,
    builder: (context) => ChangePasswordScreen(),
  ); 
}
