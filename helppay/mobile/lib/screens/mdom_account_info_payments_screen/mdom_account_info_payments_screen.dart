import 'package:flutter/material.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class MdomAccountInfoPaymentsScreen extends StatefulWidget {
  static const pageRoute = '/payments';

  final List<PaymentBilling> paymentsList;

  const MdomAccountInfoPaymentsScreen({
    Key? key,
    required this.paymentsList,
  }) : super(key: key);

  @override
  _MdomAccountInfoPaymentsScreenState createState() =>
      _MdomAccountInfoPaymentsScreenState();
}

class _MdomAccountInfoPaymentsScreenState
    extends State<MdomAccountInfoPaymentsScreen> {


  bool get isListEmpty => widget.paymentsList.isEmpty;

  @override
  Widget build(BuildContext context) => SizedBox(
        child: Scaffold(
          appBar: DialogTitle(
            text: context.t.mobileScreens.payment.title,
          ),
          body: isListEmpty
              ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.t.mobileScreens.payment.emty,
                        textAlign: TextAlign.center
                      )
                    ],
                  ),
              )
              : ListView.separated(
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemCount: widget.paymentsList.length,
                  itemBuilder: (context, index) => PaymentItem(
                    item: widget.paymentsList[index],
                  ),
                ),
        ),
      );
}
