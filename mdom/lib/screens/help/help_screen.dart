import 'package:auto_route/auto_route.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';


@RoutePage()
class HelpScreen extends StatelessWidget {
  static const pageRoute = '/help';

  const HelpScreen({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Помощь'),
    ),
    body: FullScreen(
      topSafe: false,
      bottomSafe: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Статусы требований',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppStyles.mainColor.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16),
            _claimItem(ClaimStatus.unpaid),
            _claimItem(ClaimStatus.fullyPaid),
            _claimItem(ClaimStatus.partiallyPaid),
            _claimItem(ClaimStatus.overdue),
            const SizedBox(height: 16),
            Text(
              'Статусы платежей',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppStyles.mainColor.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16),
            _paymentItem(PaymentStatus.registered),
            _paymentItem(PaymentStatus.registrationStarted),
            _paymentItem(PaymentStatus.paid),
            _paymentItem(PaymentStatus.registrationCanceled),
            _paymentItem(PaymentStatus.reversalStarted),
            _paymentItem(PaymentStatus.successfullyReversed),
            _paymentItem(PaymentStatus.refundStarted),
            _paymentItem(PaymentStatus.refundCompleted),
            _paymentItem(PaymentStatus.refundCancelWaiting),
          ],
        ),
      ),
    ),
  );

  Widget _claimItem(ClaimStatus status) => InfoItem(
    color: status.color,
    text: status.name,
  );

  Widget _paymentItem(PaymentStatus status) => InfoItem(
    color: status.color,
    text: status.name,
  );
}