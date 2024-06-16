import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/screens/payments/main_widgets/main_widgets.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class PaymentScreenBody extends StatelessWidget {
  const PaymentScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CabinetMenu(selected: MenuAvailableItem.payments),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: PageWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              //child: PageTitle('Платежи'),
                            ),
                            const SizedBox(width: 4),
                            BlocBuilder<PaymentsBloc, PaymentsState>(
                              builder: (context, state) {
                                if (state is PaymentsInitial) {
                                  return Text(
                                    '${state.payments.length}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppStyles.secondaryTextColor,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                        PaymentScreenItems(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
