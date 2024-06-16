import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';

import 'widgets.dart';

// ignore: must_be_immutable
class TableActionBar extends StatefulWidget {
  final Function(BuildContext context) openFilters;
  List<Payment> selectedPayments;

  TableActionBar({
    Key? key,
      required this.openFilters,
      required this.selectedPayments,
    }): super(key: key);

  @override
  State<TableActionBar> createState() => _TableActionBarState();
}

class _TableActionBarState extends State<TableActionBar> {

  bool isAvailableReports = false;

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
    builder: (context, mainState) {
      if(mainState is SearchPaymentActualInfo) {
          if(mainState.payments.isEmpty) {
            isAvailableReports = false;
          }
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OpenFiltersButton(
                  onAddTap: () => widget.openFilters(context),
                ),
                BlocConsumer<RowSelectedBloc<List<Payment>>, RowSelectedState<List<Payment>>>(
                  listener: (context, state) {
                    widget.selectedPayments = state.selectedData.selectedObject ?? [];
                    isAvailableReports = widget.selectedPayments.isNotEmpty;
                  },
                  builder: (context, state) => Row(
                    //where((element) => element != ReportsTypes.excelReport) 
                    children: ReportsTypes.values.map((reportType) => ActionIconElement(
                      onTap: () {
                        context.read<FormReportsBloc>().add(FormReportsInit(
                          payments: widget.selectedPayments,
                          requestData: mainState.requestData,
                          reportsType: reportType
                        ));
                      },
                      actionName: reportType.message,
                      isAvailable: isAvailableReports,
                      icon: reportType.icon,
                    )).toList()
                  ),
                ),
              ],
            ),
          );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}
