
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';

import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/payments/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';


class PaymentsTableWrapper extends StatefulWidget {
  final ScrollController controller;
  final List<Payment> selectedPayments;
  final Function() onSearchPayments;

  const PaymentsTableWrapper({
    Key? key,
    required this.controller,
    required this.onSearchPayments,
    required this.selectedPayments,
  }) : super(key: key);

  @override
  State<PaymentsTableWrapper> createState() => _PaymentsTableWrapperState();
}

class _PaymentsTableWrapperState extends State<PaymentsTableWrapper> {
  final double dataRowHeight = 30;

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
      builder: (context, state) {
        Widget body = const SizedBox();
        if (state is SearchPaymentLoading) {
          body = const Expanded(
            child: Center(
              child: LoadingIndicator(indicatorsSize: 60)),
          );
        } else if (state is SearchPaymentActualInfo) {
          body = Expanded(
            child: Column(
              children: [               
                Expanded(
                  child: RawScrollbar(
                    thumbVisibility: true,
                    interactive: true,
                    thumbColor: AppStyles.colorGrey2,
                    controller: widget.controller,
                    child: SingleChildScrollView(
                      controller: widget.controller,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 2,
                        child: PaymentsTable(
                          dataRowHeight: dataRowHeight,
                          payments: state.payments,
                          selectedPayments: widget.selectedPayments,
                        ),
                      ),
                    ),
                  )                         
                ),
                Container(
                  height: 80,
                  decoration: const BoxDecoration(border: Border(top: BorderSide( color: AppStyles.colorGrey3))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: PaymentsLoadLimitPicker(
                            selected: state.paymentLoadedLimit,
                            items: PaymentLoadedLimit.values,
                            onTap: (item) {
                              context.read<SearchPaymentBloc>().add(SearchPaymentSaveLimits(paymentLoadedLimit: item));
                            },
                          ),
                        ),
                        if (state.payments.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: LoadMorePaymentsIconButton(
                              isActive: state.isActiveNextLoaded,
                              onTap: () async{
                                final requestData =
                                    state.requestData.copyWith(
                                      prevDate: state.payments.last.payDate,
                                      prevSourceId: state.payments.last.sourceId,
                                      prevIdxOnsecond: state.payments.last.idxOnSecond
                                    );
                                await _onSearchPayments(requestData);
                              },
                            ),
                          )
                        else
                          const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return body;
      },
    );

  Future<void> _onSearchPayments(SearchPaymentData searchPaymentBody) async{
    context.read<WebSocketBloc>().add(WebSocketInitialize());
    context.read<SearchPaymentBloc>().add(SearchPaymentInitialize(
      searchPaymentBody: searchPaymentBody,
      searchPaymentMethod: searchPaymentBody.searchPaymentMethod ?? SearchPaymentMethod.full
    ));
  } 
}
