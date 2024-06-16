import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class ArchivePartTable extends StatefulWidget {
  final List<ArchiveDBPart> archiveParts;

  const ArchivePartTable({
    Key? key,
    required this.archiveParts,
  }) : super(key: key);

  @override
  State<ArchivePartTable> createState() => _ArchivePartTableState();
}

class _ArchivePartTableState extends State<ArchivePartTable> {

  bool sortAscending = true;
  int sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) => TableWrapper(
    sortAscending: sortAscending,
    sortColumnIndex: sortColumnIndex,
    columnWidthRatio: 0.20,
    headingRowHeight: 35,
    dataListLength: widget.archiveParts.length,
    columns: [
    ...ArchivePartTableColumns.values.map((e) => DataColumn2(
        onSort: (columnIndex, ascending) {
          context.read<ArchivePartBloc>().add(ArchivePartSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
    source: ArchivePartTableData(
      context: context,
      archiveParts: widget.archiveParts
    ),
  );
}
