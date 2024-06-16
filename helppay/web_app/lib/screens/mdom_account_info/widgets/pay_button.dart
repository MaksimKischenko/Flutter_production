import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class PayButton extends StatelessWidget {
  final Function() onPayTap;

  const PayButton({
    Key? key,
    required this.onPayTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MdomAccountInfoBloc, MdomAccountInfoState>(
        builder: (context, state) {
          // ignore: unused_local_variable
          Widget? body = Container();
          if (state is MdomAccountInfoLoading) {
            body = MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              highlightElevation: 0,
              minWidth: double.maxFinite,
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 15, bottom: 14),
              child: const LoadingIndicator(),
            );
          } else if (state is MdomAccountInfoError) {
            // return const SizedBox.shrink();
          } else if (state is MdomAccountInfoErrorKomplat) {
            // return const SizedBox.shrink();
          }
          //  else if (state is MdomAccountInfoLoaded) {
          //   final balance = state.periodInfo?.servicesWrapper?.services?.fold<
          //               Decimal>(
          //           Decimal.zero,
          //           (sum, service) =>
          //               sum +
          //               Decimal.parse((service.balance ?? 0.0).toString())) ??
          //       Decimal.zero;
          //   final fine = state.periodInfo?.servicesWrapper?.services
          //           ?.fold<Decimal>(
          //               Decimal.zero,
          //               (sum,
          //                       service) =>
          //                   sum +
          //                   Decimal.parse((service.fine ?? 0.0).toString())) ??
          //       Decimal.zero;
          //   final totalSum = state.periodInfo?.servicesWrapper?.services
          //           ?.fold<Decimal>(
          //               Decimal.zero,
          //               (sum, service) =>
          //                   sum + Decimal.parse(service.total.toString())) ??
          //       Decimal.zero;
          //   final paymentSum = state.periodInfo?.paymentsWrapper?.payments
          //           ?.fold<Decimal>(
          //               Decimal.zero,
          //               (sum, payment) =>
          //                   sum + Decimal.parse(payment.amount.toString())) ??
          //       Decimal.zero;
          //   //final payAmount = (totalSum - paymentSum).toDouble();
          //   final payAmount =
          //       (balance + fine + totalSum - paymentSum).toDouble();

          //   if (payAmount >= 0) {
          //     // body = _button(
          //     //   onPressed: onPayTap,
          //     //   text: context.t.mobileScreens.mdomAccountInfo.payButton.needPay(
          //     //     amount: payAmount,
          //     //     currency: CoreConfig.currency,
          //     //   ),
          //     // );
          //   } else {
          //     body = _info(
          //       text:
          //           context.t.mobileScreens.mdomAccountInfo.payButton.noNeedPay(
          //         amount: payAmount.abs(),
          //         currency: CoreConfig.currency,
          //       ),
          //     );
          //   }
          // } else if (state is MdomAccountInfoPeriodNotSet) {
          //   body = _button(
          //     onPressed: () => AutoRouter.of(context).pop(),
          //     text:
          //         context.t.mobileScreens.mdomAccountInfo.payButton.noPayments,
          //   );
          // }

          return _button(
            onPressed: () => AutoRouter.of(context).pop(),
            text: context.t.mobileScreens.mdomAccountInfo.payButton.noPayments,
          );
          // ?? const SizedBox.shrink();
        },
      );

  Widget _button({required Function() onPressed, required String text}) =>
      MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        highlightElevation: 0,
        minWidth: double.maxFinite,
        color: AppStyles.mainColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}

// Widget _info({required String text}) => Text(
//       text,
//       textAlign: TextAlign.center,
//       style: const TextStyle(
//         color: AppStyles.mainColor,
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//       ),
//     );
