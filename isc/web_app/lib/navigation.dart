import 'package:flutter/material.dart';
import 'package:isc_web_app/models/models.dart';
import 'screens/claims_filter/claims_filter_web_screen.dart';
import 'screens/payments_filter/payments_filter_web_screen.dart';
import 'utils/utils.dart';

// ignore: avoid_classes_with_only_static_members
class Navigation {

  static Future<ClaimsFilterData?> toClaimsFilters({
    required BuildContext context,
    required ClaimsFilterData currentFilters,
  }) => Multiplatform.showWebDialog<ClaimsFilterData>(
      context: context,
      // padding: const EdgeInsets.all(50),
      builder: (context) => ClaimsFilterWebScreen(
        data: currentFilters,
      ),
    );

  static Future<PaymentsFilterData?> toPaymentsFilters({
    required BuildContext context,
    required PaymentsFilterData currentFilters,
  }) => Multiplatform.showWebDialog<PaymentsFilterData>(
      context: context,
      builder: (context) => PaymentsFilterWebScreen(
        data: currentFilters,
      ),
    );  
}
