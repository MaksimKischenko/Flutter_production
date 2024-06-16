// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';

class PaymentTableData extends DataTableSource {

  final List<Payment> payments;
  final List<Payment> selectedPaymnets;
  final BuildContext context;

  PaymentTableData({
    required this.payments,
    required this.selectedPaymnets,
    required this.context,
  });


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => payments.length;

  @override
  int get selectedRowCount => 10;

  Color statusColor(int index) {
    if(payments[index].status == -1) {
      return Colors.red;  
    }
    if(payments[index].status == -4) {
      return Colors.yellow;  
    }
    else {
      return AppStyles.colorGrey;
    }
  }

  
  @override
  DataRow2 getRow(int index) => DataRow2(
    onTap: () {
        if(!selectedPaymnets.contains(payments[index])) {
          selectedPaymnets.add(payments[index]);
          BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: true, selectedObject: selectedPaymnets)));
          //BlocProvider.of<RowSelectedBloc>(context).add(RowSelectedRun(selectedData: PaymentSelectedRowData(isSelected: true, selectedPayments: selectedPaymnets)));
        } 
        else {
          selectedPaymnets.remove(payments[index]);
          BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: selectedPaymnets)));
          if(selectedPaymnets.isEmpty) {
            BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: [])));
          }
        }            
      notifyListeners();
    },    
    selected: selectedPaymnets.contains(payments[index]),
    color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if(states.contains(MaterialState.hovered)) {
        return Colors.transparent;
      }
      if (states.contains(MaterialState.selected)) {
        return AppStyles.colorBlue3; 
      } else {
        if(payments[index].status == -1) {
          return Colors.red;  
        }
        if(payments[index].status == -4) {
          return Colors.yellow;  
        }
        else {
          return Colors.transparent;
        }
      }
    }),
    cells:[
      DataCell(
        SelectBox(
          value: selectedPaymnets.contains(payments[index]),
          onChanged: (value) {
              if(!selectedPaymnets.contains(payments[index])) {
                selectedPaymnets.add(payments[index]);
                BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: true, selectedObject: selectedPaymnets)));
                //BlocProvider.of<RowSelectedBloc>(context).add(RowSelectedRun(selectedData: PaymentSelectedRowData(isSelected: true, selectedPayments: selectedPaymnets)));
              } 
              else {
                selectedPaymnets.remove(payments[index]);
                BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: selectedPaymnets)));
                if(selectedPaymnets.isEmpty) {
                  BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: [])));
                }
              }            
            notifyListeners();
          },
        )
      ),      
      DataCell(Text(payments[index].payerFullName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].payerAddress ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].fullNameDepositor ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].depositorAddress ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(
        Tooltip(
          message: payments[index].supplierName ?? '',
          height: 50,
          child: Text(payments[index].supplierName ?? '', style: AppStyles.tableDataTextStyle))),
      DataCell(Text(payments[index].serviceName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].supplierAccount ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].bankName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].bankBik ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].budgetCode.toString().replaceAll('null', ''), style: AppStyles.tableDataTextStyle)),
      DataCell(Text((payments[index].paySum ?? 0.0).toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text((payments[index].commissionSum ?? 0.0).toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text((payments[index].penaltySum ?? 0.0).toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].terminalId ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].terminalDept?.toString().replaceAll('null', '') ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].deptFilial?.toString().replaceAll('null', '')  ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].terminaLocation ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].receiptNo ?? '', style: AppStyles.tableDataTextStyle)),  
      DataCell(Text(payments[index].externalSystemPaymentId.toString().replaceAll('null', '') , style: AppStyles.tableDataTextStyle)),  
      DataCell(Text(payments[index].payDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].consolidatedDocDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].consolidatedDocId?.toString().replaceAll('null', '')  ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].consolidatedDocPayString ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].consolidatedExportFileName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(payments[index].region ?? '', style: AppStyles.tableDataTextStyle)), 
      DataCell(Text(payments[index].cardNumber ?? '', style: AppStyles.tableDataTextStyle)),                            
    ],
  );
}
