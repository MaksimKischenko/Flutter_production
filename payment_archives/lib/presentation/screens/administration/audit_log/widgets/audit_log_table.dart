// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class AuditLogTable extends StatefulWidget {
  
  final List<AuditLog> auditLogs;

  const AuditLogTable({
    Key? key,
    required this.auditLogs,
  }) : super(key: key);

  @override
  State<AuditLogTable> createState() => _AuditLogTableState();
}

class _AuditLogTableState extends State<AuditLogTable> {

  bool sortAscending = true;
  int sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) => TableWrapper(
    sortAscending: sortAscending,
    sortColumnIndex: sortColumnIndex,    
    columnWidthRatio: 0.3,
    headingRowHeight: 35,
    dataListLength: widget.auditLogs.length, 
    columns: [
      ...AuditLogTableColumns.values.map((e) => DataColumn2(
          onSort: (columnIndex, ascending) {
            context.read<AuditLogBloc>().add(AuditLogSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
          )))
    ],
    source: AuditLogTableData(
      auditLogs: widget.auditLogs,
      context: context,
    )
  );
}




