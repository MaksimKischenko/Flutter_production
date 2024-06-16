import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/screens/payments/main_widgets/payment_buttons_row.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

import '../widgets/widgets.dart';

class PaymentScreenItems extends StatelessWidget {
  const PaymentScreenItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PaymentsBloc, PaymentsState>(
        listener: (context, state) {
          if (state is PaymentsDeletePaymentSuccess) {
            Multiplatform.showMessage(
                context: context,
                title: 'Успешно',
                message: 'Платеж ${state.id} удален из корзины',
                type: DialogType.success);
          }
        },
        builder: (context, state) {
          Widget body = Container();
          if (state is PaymentsInitial) {
            body = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // PageSubtitle('кол-во: ${state.payments.length}. Сумма ${state.totalAmount}'),
                const SizedBox(height: 32),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.payments.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => PaymentItem(
                    item: state.payments[index],
                    onDeleteTap: (item) => context.read<PaymentsBloc>().add(
                          PaymentsDeletePayment(item),
                        ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
                const SizedBox(height: 32),
                PaymentButtonRow(
                  isPayButtonActive: state.payments.isNotEmpty,
                  totalAmount: state.totalAmount,
                ),
              ],
            );
          } else if (state is PaymentsLoading) {
            body = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LoadingIndicator(),
              ],
            );
          }
          return body;
        },
      );
}
