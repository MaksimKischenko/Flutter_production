import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/widgets.dart';

class PaymentButtonRow extends StatelessWidget {
  final bool isPayButtonActive;
  final double totalAmount;
  const PaymentButtonRow({
    Key? key,
    required this.isPayButtonActive,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isMobile) {
            // small
            return Column(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 170),
                  child: PayButton(
                    isActive: isPayButtonActive,
                    onTap: _onPayTap,
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text: 'Общая сумма: ',
                    style: const TextStyle(color: AppStyles.secondaryTextColor),
                    children: [
                      TextSpan(
                        text:
                            ' $totalAmount ${AppConfig.mapCurrencyToName[AppConfig.defaultCurrency]}',
                        style: const TextStyle(
                          color: AppStyles.mainTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                // const SizedBox(width: 44),
              ],
            );
          } else {
            // normal
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 170),
                  child: PayButton(
                    isActive: isPayButtonActive,
                    onTap: (context) => _onPayTap(context),
                  ),
                ),
                const SizedBox(width: 16),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    text: 'Общая сумма: ',
                    style: const TextStyle(color: AppStyles.secondaryTextColor),
                    children: [
                      TextSpan(
                        text:
                            ' $totalAmount ${AppConfig.mapCurrencyToName[AppConfig.defaultCurrency]}',
                        style: const TextStyle(
                          color: AppStyles.mainTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 44),
              ],
            );
          }
        },
      );

  void _onPayTap(BuildContext context) {
    context.read<ConfirmBloc>().add(
          ConfirmRun(),
        );
  }
}
