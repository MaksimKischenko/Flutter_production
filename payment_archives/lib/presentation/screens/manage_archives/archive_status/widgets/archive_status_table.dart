import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class ArchiveStatusTable extends StatefulWidget {
  final List<ArchiveStatus> archiveStatuses;

  const ArchiveStatusTable({
    Key? key,
    required this.archiveStatuses,
  }) : super(key: key);

  @override
  State<ArchiveStatusTable> createState() => _ArchiveStatusTableState();
}

class _ArchiveStatusTableState extends State<ArchiveStatusTable> {

  bool sortAscending = true;
  int sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) => TableWrapper(
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
      columnWidthRatio: 0.08,
      headingRowHeight: 35,
      dataListLength: widget.archiveStatuses.length,
      columns: [
      ...ArchiveStatusTableColumns.values.map((e) => DataColumn2(
          onSort: (columnIndex, ascending) {
            context.read<ArchiveStatusBloc>().add(ArchiveStatusSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
      source: ArchiveStatusTableData(
        context: context,
        archiveStatuses: widget.archiveStatuses
      ),
    );
}
