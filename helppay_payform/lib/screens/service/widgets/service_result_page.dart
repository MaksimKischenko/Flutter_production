import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/payment/payment_bloc.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tuple/tuple.dart';

import 'widgets.dart';

class ServiceResultPage extends StatefulWidget {
  final PayRecordResponse service;
  final int diType;
  final String name;
  final List<AttrRecordRequest> lastAttrs;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final bool isDevice;

  const ServiceResultPage(
      {required this.service,
      required this.diType,
      required this.name,
      required this.lastAttrs,
      required this.finishedAttrs,
      required this.isDevice});

  @override
  _ServiceResultPageState createState() => _ServiceResultPageState();
}

class _ServiceResultPageState extends State<ServiceResultPage> {
  @override
  Widget build(BuildContext context) => BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: widget.finishedAttrs.length,
              itemBuilder: (context, index) => _buildItem(index),
              separatorBuilder: (context, _) => Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
              ),
            ),
            const SizedBox(height: 10),
            // amount
            SumText(
              sum: widget.service.summa ?? 0.0,
              currency: widget.service.currency ?? AppConfig.defaultCurrency,
            ),
            const SizedBox(height: 48),
            _footer(),
          ],
        ),
      );

  Widget _buildItem(int index) {
    final attr = widget.finishedAttrs[index];
    return ServiceResultItem(
      title: attr.item1,
      subtitle: attr.item2,
    );
  }

  Widget _footer() => ResponsiveBuilder(builder: (context, sizingInformation) {
        if (widget.isDevice) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NextButton(
                onPressed: _onPayTap,
                text: 'Отправить заявку',
              ),
              const SizedBox(height: 16),
              AgainButton(
                onTap: () =>
                    Navigation.toService(widget.service.code!, widget.diType, widget.name),
              ),
            ],
          );
        } else {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AgainButton(
                  onTap: () =>
                      Navigation.toService(widget.service.code!, widget.diType, widget.name),
                ),
                const SizedBox(width: 16),
                NextButton(
                  onPressed: _onPayTap,
                  text: 'Отправить заявку',
                ),
              ],
            ),
          );
        }
      });

  void _onPayTap() {
    context.read<PaymentBloc>().add(PaymentFinish());
  }
}
