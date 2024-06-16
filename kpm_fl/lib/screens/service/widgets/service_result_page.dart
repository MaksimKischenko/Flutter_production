import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/blocs/payment/payment_bloc.dart';
import 'package:kpm_fl/config.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

import 'widgets.dart';

class ServiceResultPage extends StatefulWidget {
  final PayRecordResponse service;
  final List<AttrRecordRequest> lastAttrs;
  final List<Tuple2<String, dynamic>> finishedAttrs;

  const ServiceResultPage({
    required this.service,
    required this.lastAttrs,
    required this.finishedAttrs
  });

  @override
  _ServiceResultPageState createState() => _ServiceResultPageState();
}

class _ServiceResultPageState extends State<ServiceResultPage> {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: widget.finishedAttrs.length,
                    itemBuilder: (context, index) => _buildItem(index),
                    separatorBuilder: (context, _) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      // child: Divider(
                      //   color: AppStyles.secondaryTextColor.withOpacity(0.1)
                      // ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // amount 
                  SumText(
                    sum: widget.service.summa ?? 0.0,
                    currency: widget.service.currency ?? AppConfig.defaultCurrency,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      // menu
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GradientButton(
                  onTap: _onAddToBasketTap,
                  gradientColors: const [
                    CupertinoColors.systemGreen,
                    CupertinoColors.systemGreen,
                  ],
                  child: Text(ScreenInfo.of(context).service.resultStep.addToBasketButtonLabel),
                ),
              )
            ),
            // if (!_hasBasketPayments)
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 16),
            //     child: GradientButton(
            //       onTap: _onPayTap,
            //       gradientColors: const [
            //         CupertinoColors.systemGreen,
            //         CupertinoColors.systemGreen,
            //       ],
            //       child: Text(ScreenInfo.of(context).service.resultStep.payButtonLabel),
            //       // child: Text(),
            //     ),
            //   )
            // ),
            const SizedBox(width: 16),
            Expanded(
              child: GradientButton(
                onTap: _onRestartTap,
                gradientColors: AppStyles.buttonGradientColorsRed,
                // TODO: add real text from ScreenInfo
                child: const Text('В начало'),
                // child: Text(),
              )
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GradientButton(
                onTap: _onHomeTap,
                gradientColors: const [
                  AppStyles.mainColor,
                  AppStyles.mainColor,
                ],
                child: Text(ScreenInfo.of(context).service.resultStep.homeButtonLabel),
                // child: Text(),
              )
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      const SizedBox(height: 16),
    ],
  );

  Widget _buildItem(int index) {
    final attr = widget.finishedAttrs[index];
    return ServiceResultItem(
      title: attr.item1,
      subtitle: attr.item2,
    );
  }

  void _onAddToBasketTap() {
    context.read<PaymentBloc>().add(PaymentFinish());
  }

  void _onPayTap() {
    // TODO
  }

  void _onRestartTap() {
    Navigation.toService(widget.service.code!);
  }

  void _onHomeTap() {
    Navigation.toPopularServices();
    // Navigation.toSplash();
  }
}