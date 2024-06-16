// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';


class AuditLogTableData extends DataTableSource {

  final BuildContext context;
  final List<AuditLog> auditLogs;

  AuditLogTableData({
    required this.context,
    required this.auditLogs,
  });

  final int _selectedRow = -1;

  
  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => auditLogs.length;

  @override
  int get selectedRowCount => 10;
  
  @override
  DataRow2 getRow(int index) => DataRow2(  
    selected: _selectedRow == index,
    color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return AppStyles.colorBlue3; 
      } else {
        if(index.isEven) {
          return Colors.transparent;  
        } else {
          return AppStyles.colorGrey3.withOpacity(0.3);
        }
      }
    }),
    cells:[     
      DataCell(Text('${auditLogs[index].logId}', style: AppStyles.tableDataTextStyle)),
      DataCell(Text('${auditLogs[index].userId ?? ''}', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(auditLogs[index].userName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(auditLogs[index].fullUserName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text('${auditLogs[index].opDateTime?.toStringFormattedRunOperation()}', style: AppStyles.tableDataTextStyle)),
      DataCell(Text('${auditLogs[index].actionId ?? ''}', style: AppStyles.tableDataTextStyle)),
      DataCell(
        Tooltip(
          message: '${auditLogs[index].opDescr}',
          height: 50,
          child: Text('${auditLogs[index].opDescr}', style: AppStyles.tableDataTextStyle, overflow: TextOverflow.ellipsis,))),
      DataCell(Text('${auditLogs[index].ipAddress}', style: AppStyles.tableDataTextStyle)),
    ],
  );
}

