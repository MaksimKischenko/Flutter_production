import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class PayInfo extends StatelessWidget {

  const PayInfo({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<MdomAccountInfoBloc, MdomAccountInfoState>(
    builder: (context, state) {
      if (state is MdomAccountInfoLoaded) {
        final totalSum = state.periodInfo?.servicesWrapper?.services?.fold<Decimal>(Decimal.zero, (sum, service) => sum + Decimal.parse(service.total.toString())) ?? Decimal.zero;
        final paymentSum = state.periodInfo?.paymentsWrapper?.payments?.fold<Decimal>(Decimal.zero, (sum, payment) => sum + Decimal.parse(payment.amount.toString())) ?? Decimal.zero;
        final payAmount = (totalSum - paymentSum).toDouble();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            context.t.mobileScreens.mdomAccountInfo.payInfo(
              amount: payAmount,
              currency: CoreConfig.currency
            ),
            style: const TextStyle(
              color: AppStyles.mainColor,
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}