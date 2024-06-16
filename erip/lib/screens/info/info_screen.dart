import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class InfoScreen extends StatelessWidget {
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
            _getClaimItem(1),
            _getClaimItem(3),
            _getClaimItem(2),
            _getClaimItem(4),
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
            _getPaymentItem(1),
            // _getPaymentItem(-3),
            _getPaymentItem(2),
            // _getPaymentItem(-4),
            // _getPaymentItem(-2),
            _getPaymentItem(-1),
            _getPaymentItem(-9),
            _getPaymentItem(-10),
            _getPaymentItem(-11),
          ],
        ),
      ),
    ),
  );

  Widget _getClaimItem(int status) => InfoItem(
    color: Claim.statusesColor[status]!,
    text: Claim.statusesText[status]!,
  );

  Widget _getPaymentItem(int status) => InfoItem(
    color: Payment.statusesColor[status]!,
    text: Payment.statusesText[status]!,
  );
}