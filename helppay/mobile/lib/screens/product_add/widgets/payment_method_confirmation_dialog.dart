import 'package:flutter/material.dart';
import 'package:helppay/screens/product_add/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/data/remote_models/mdom_base_models.dart';

class PaymentMethodConfirmationDialog extends StatelessWidget {
  final List<MdomResponseParam> paymentMethodData;
  final int requestId;
  final String typePan;

  const PaymentMethodConfirmationDialog({
    required this.paymentMethodData,
    required this.requestId,
    super.key,
    required this.typePan,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // padding: MediaQuery.of(context).viewInsets,
        height: MediaQuery.of(context).copyWith().size.height -
            (MediaQuery.of(context).padding.top +
                MediaQuery.of(context).copyWith().size.height / 3.4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            // child: builder(context, null),
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Подтверждение счёта',
                  style: TextStyle(
                    color: AppStyles.mainColorDark,
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                    child: Text(
                      'Используйте полученный код из СМС сообщения для подтверждения регистрации счёта',
                      style: TextStyle(
                        color: AppStyles.mainColorDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // SizedBox(height: 50),
                  Expanded(
                    child: AddProductPinFieldWidget(
                      requestId: requestId,
                      paymentMethodData: paymentMethodData,
                      typePan: typePan,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
