import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

@RoutePage()
class MdomAccountInfoPaymentsScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/payments');

  // static const pageRoute = '/payments';

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
        child: WebDialogWindow(
          title: context.t.mobileScreens.payment.title,
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          buttonActive: true,
          buttonTitle: 'Готов',
          useSpacer: false,
          body: isListEmpty
              ? Center(
                  child: Text(context.t.mobileScreens.payment.emty,
                      textAlign: TextAlign.center),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemCount: widget.paymentsList.length,
                  itemBuilder: (context, index) => PaymentItem(
                    item: widget.paymentsList[index],
                  ),
                ),
        ),
      );
}
