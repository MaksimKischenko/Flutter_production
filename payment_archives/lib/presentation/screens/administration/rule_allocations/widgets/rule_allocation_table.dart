// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class RuleAllocationTable extends StatefulWidget {
  final List<RuleAllocationData> ruleAllocations;

  const RuleAllocationTable({
    Key? key,
    required this.ruleAllocations,
  }) : super(key: key);

  @override
  State<RuleAllocationTable> createState() => _RuleAllocationTableState();
}

class _RuleAllocationTableState extends State<RuleAllocationTable> {

  bool sortAscending = true;
  int sortColumnIndex = 1;  

  @override
  Widget build(BuildContext context) => TableWrapper(
    sortAscending: sortAscending,
    sortColumnIndex: sortColumnIndex,      
    columnWidthRatio: 0.20,
    headingRowHeight: 35,
    dataListLength: widget.ruleAllocations.length,
    columns: [
    ...RuleAllocationsTableColumns.values.map((e) => DataColumn2(
        onSort: (columnIndex, ascending) {
          context.read<RuleAllocationBloc>().add(RuleAllocationSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
    source: RuleAllocationTableData(
      context: context,
      ruleAllocations: widget.ruleAllocations
    )
  );
}
