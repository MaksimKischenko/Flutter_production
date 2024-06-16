// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';

class ClaimTableData extends DataTableSource {

  final List<Claim> claims;
  final BuildContext context;
  final SettingsInitial state;

  ClaimTableData({
    required this.claims,
    required this.context,
    required this.state
  });


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => claims.length;

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
        if(claims[index].status == ClaimStatus.all) {
          return Colors.transparent;
        }
        if(claims[index].status == ClaimStatus.overdue) {
          return claims[index].status.claimStatusColor.withOpacity(0.5);  
        }
        if(claims[index].status == ClaimStatus.fullyPaid) {
          return claims[index].status.claimStatusColor.withOpacity(0.5);  
        }
        if(claims[index].status == ClaimStatus.partiallyPaid) {
          return claims[index].status.claimStatusColor.withOpacity(0.5);  
        }
        if(claims[index].status == ClaimStatus.unpaid) {
          return claims[index].status.claimStatusColor.withOpacity(0.5);  
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
        color: claims[index].status.claimStatusColor,
      )), 
      if (state.claimItems.contains(ClaimsTableColumns.claimCode.columnName)) 
      DataCell(Text(claims[index].id.toString(), style: AppStyles.tableDataTextStyle)),

      if (state.claimItems.contains(ClaimsTableColumns.accountName.columnName)) 
      DataCell(Text(claims[index].accNum, style: AppStyles.tableDataTextStyle)),

      if (state.claimItems.contains(ClaimsTableColumns.invoiceDate.columnName)) 
      DataCell(Text(claims[index].invoiceDate, style: AppStyles.tableDataTextStyle)),

      if (state.claimItems.contains(ClaimsTableColumns.dueDate.columnName)) 
      DataCell(Text(claims[index].dueDate, style: AppStyles.tableDataTextStyle)),

      if (state.claimItems.contains(ClaimsTableColumns.fio.columnName)) 
      DataCell(Text(claims[index].fio ?? '', style: AppStyles.tableDataTextStyle)),   

      if (state.claimItems.contains(ClaimsTableColumns.summ.columnName)) 
      DataCell(Text(claims[index].sum.toString().replaceAll('null', ''), style: AppStyles.tableDataTextStyle)),

      if (state.claimItems.contains(ClaimsTableColumns.paySumm.columnName)) 
      DataCell(Text((claims[index].paymentSum).toString(), style: AppStyles.tableDataTextStyle)),

      if (state.claimItems.contains(ClaimsTableColumns.status.columnName)) 
      DataCell(Text(claims[index].status.claimStatusName, style: AppStyles.tableDataTextStyle)),  
       
      DataCell(
        Center(
          child: Container(
            color: Colors.white.withOpacity(0.3),
            padding: const EdgeInsets.all(2),
            child: PopupMenuButton<ClaimsActionsTypes>(
              onSelected: (value) {
                switch (value) {
                  case ClaimsActionsTypes.view:
                  AutoRouter.of(context).push(ClaimInfoRoute(
                    claimId: claims[index].id,
                    claim: claims[index]
                  ));
                }
              },
              itemBuilder: (BuildContext context) => ClaimsActionsTypes.values.map<PopupMenuItem<ClaimsActionsTypes>>((action) 
              => PopupMenuItem<ClaimsActionsTypes>(
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
