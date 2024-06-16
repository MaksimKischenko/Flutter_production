import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class ArchiveLocationTable extends StatefulWidget {
  final List<ArchiveLocation> archiveLocations;

  const ArchiveLocationTable({
    Key? key,
    required this.archiveLocations,
  }) : super(key: key);

  @override
  State<ArchiveLocationTable> createState() => _ArchiveLocationTableState();
}

class _ArchiveLocationTableState extends State<ArchiveLocationTable> {

  bool sortAscending = true; 
  int sortColumnIndex = 1; 

  @override
  Widget build(BuildContext context) =>  TableWrapper(
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,      
      columnWidthRatio: 0.25,
      headingRowHeight: 35,
      dataListLength: widget.archiveLocations.length,
      columns: [
        ...ArchiveLocationTableColumns.values.map((e) => DataColumn2(
            onSort: (columnIndex, ascending) {
              context.read<ArchiveLocationBloc>().add(ArchiveLocationSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
      source: ArchiveLocationTableData(
        context: context,
        archiveLocations: widget.archiveLocations
      )
    );
}
