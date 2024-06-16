// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';

class PaymentTableData extends DataTableSource {

  final List<PaymentISC> payments;
  final BuildContext context;
  final SettingsInitial state; 

  PaymentTableData({
    required this.payments,
    required this.context,
    required this.state
  });


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => payments.length;

  @override
  int get selectedRowCount => 10;
  
  @override
  DataRow2 getRow(int index) => DataRow2(
    onTap: () {

    },    
    //selected: selectedPaymnets.contains(payments[index]),
    color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if(states.contains(MaterialState.hovered)) {
        return Colors.transparent;
      }
      if (states.contains(MaterialState.selected)) {
        return Colors.transparent; 
      } else {
        if(payments[index].status == PaymentStatus.all) {
          return Colors.transparent;
        }
        if(payments[index].status == PaymentStatus.registered) {
          return payments[index].status.paymentStatusColor.withOpacity(0.5);  
        }
        if(payments[index].status == PaymentStatus.paid) {
          return payments[index].status.paymentStatusColor.withOpacity(0.5);  
        }
        if(payments[index].status == PaymentStatus.successfullyReversed) {
          return payments[index].status.paymentStatusColor.withOpacity(0.5);  
        }
        if(payments[index].status == PaymentStatus.reversalStarted) {
          return payments[index].status.paymentStatusColor.withOpacity(0.5);  
        } 
        if(payments[index].status == PaymentStatus.registrationStarted) {
          return payments[index].status.paymentStatusColor.withOpacity(0.5);  
        }
        if(payments[index].status == PaymentStatus.registrationCanceled) {
          return Colors.transparent;//payments[index].status.paymentStatusColor.withOpacity(0.5);  
        }         
        else {
          return Colors.transparent;
        }
      }
    }),
    cells:[
      // DataCell(
      //   WebCheckBox(
      //     value: selectedPaymnets.contains(payments[index]),
      //     onChanged: (value) {
      //         if(!selectedPaymnets.contains(payments[index])) {
      //           selectedPaymnets.add(payments[index]);
      //           BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: true, selectedObject: selectedPaymnets)));
      //           //BlocProvider.of<RowSelectedBloc>(context).add(RowSelectedRun(selectedData: PaymentSelectedRowData(isSelected: true, selectedPayments: selectedPaymnets)));
      //         } 
      //         else {
      //           selectedPaymnets.remove(payments[index]);
      //           BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: selectedPaymnets)));
      //           if(selectedPaymnets.isEmpty) {
      //             BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: [])));
      //           }
      //         }            
      //       notifyListeners();
      //     },
      //   )
      // ),     
      DataCell(
       Container(
        width: 10,
        color: payments[index].status.paymentStatusColor,
      )), 
      
      if (state.paymnetItems.contains(PaymentsTableColumns.accNum.columnName))
      DataCell(Text(payments[index].accNum ?? '', style: AppStyles.tableDataTextStyle)),

      if (state.paymnetItems.contains(PaymentsTableColumns.memNumber.columnName))
      DataCell(Text(payments[index].memNumber, style: AppStyles.tableDataTextStyle)),

      if (state.paymnetItems.contains(PaymentsTableColumns.memDate.columnName))
      DataCell(Text(payments[index].memDate, style: AppStyles.tableDataTextStyle)),

      if (state.paymnetItems.contains(PaymentsTableColumns.fio.columnName))
      DataCell(Text(payments[index].fio ?? '', style: AppStyles.tableDataTextStyle)), 

      if (state.paymnetItems.contains(PaymentsTableColumns.id.columnName))
      DataCell(Text(payments[index].id.toString(), style: AppStyles.tableDataTextStyle)),

      if (state.paymnetItems.contains(PaymentsTableColumns.paymentDate.columnName))
      DataCell(Text(payments[index].paymentDate, style: AppStyles.tableDataTextStyle)), 

      if (state.paymnetItems.contains(PaymentsTableColumns.paymentSum.columnName))
      DataCell(Text(payments[index].paymentSum.toString(), style: AppStyles.tableDataTextStyle)),

      if (state.paymnetItems.contains(PaymentsTableColumns.claimId.columnName))
      DataCell(Text((payments[index].claimId).toString(), style: AppStyles.tableDataTextStyle)),

      if (state.paymnetItems.contains(PaymentsTableColumns.status.columnName))
      DataCell(Text(payments[index].status.paymentStatusName, style: AppStyles.tableDataTextStyle)),   

      DataCell(
        Center(
          child: Container(
            color: Colors.white.withOpacity(0.3),
            padding: const EdgeInsets.all(2),
            child: PopupMenuButton<PaymentsActionsTypes>(
              onSelected: (value) {
                switch (value) {
                  case PaymentsActionsTypes.view:
                  AutoRouter.of(context).push(PaymentInfoRoute(
                    paymentId: payments[index].id,
                    payment: payments[index]
                  ));
                }
              },
              itemBuilder: (BuildContext context) => PaymentsActionsTypes.values.map<PopupMenuItem<PaymentsActionsTypes>>((action) 
              => PopupMenuItem<PaymentsActionsTypes>(
                value: action,
                child: Text(action.actionName),
              )).toList(),
              child: const Icon(
                Icons.more_horiz_rounded,
                size: 16,
              ),
            ),
          ),
        )
      ),                           
    ],
  );
}
