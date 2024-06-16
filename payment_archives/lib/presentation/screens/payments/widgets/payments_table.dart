import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/payments/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class PaymentsTable extends StatefulWidget {
  final List<Payment> payments;
  final List<Payment> selectedPayments;
  final double dataRowHeight;

  const PaymentsTable({
    Key? key,
    required this.payments,
    required this.selectedPayments,
    this.dataRowHeight = 30
  }) : super(key: key);

  @override
  State<PaymentsTable> createState() => PaymentsTableState();
}

class PaymentsTableState extends State<PaymentsTable> {
  bool selectAll = false;
  bool sortAscending = true;
  int sortColumnIndex = 1;


  @override
  Widget build(BuildContext context) => TableWrapper(
    columnWidthRatio: 0.3,
    headingRowHeight: 50,
    sortAscending: sortAscending,
    canZoom: true,
    additionalElements: PaymentStornoTableItem(),
    dataRowHeight: widget.dataRowHeight,
    sortColumnIndex: sortColumnIndex,
    dataListLength: widget.payments.length,
    columns: [
      DataColumn2(
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectBox(
              borderSideColor: AppStyles.whiteColor,
              value: selectAll,
              onChanged: (value) {
                setState(() {
                  selectAll = value;
                  if(selectAll) {
                    widget.selectedPayments.addAll(widget.payments.where((element) => element.uuid != '1' && !widget.selectedPayments.contains(element)));
                    BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: true, selectedObject: widget.selectedPayments)));
                  } else {
                    widget.selectedPayments.clear();
                    BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: widget.selectedPayments)));
                  }
                });
              },
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      size: ColumnSize.S,
    ),
    ...PaymentTableColumns.values.map((e) => DataColumn2(
      onSort: (columnIndex, ascending) {
          context.read<SearchPaymentBloc>().add(SearchPaymentSort(ascending: sortAscending, sortIndex: sortColumnIndex));
          setState(() {
            sortAscending = !sortAscending;
            sortColumnIndex = columnIndex;
          });  
      },
      size: e.columnSize,
      label: Text(
        e.name, 
        style: AppStyles.tableHeaderTextStyle, 
        overflow: TextOverflow.ellipsis,   
        textAlign: TextAlign.left,       
      ))
      ),      
    ],
    source: PaymentTableData(
      context: context,
      payments: widget.payments,
      selectedPaymnets: widget.selectedPayments,
    )
  ); 
}
