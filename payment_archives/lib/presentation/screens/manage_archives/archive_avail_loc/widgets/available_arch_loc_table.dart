import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class AvailableArchiveLocationTable extends StatefulWidget {
  final List<AvailableArchiveLocation> availableArchiveLocations;

  const AvailableArchiveLocationTable({
    Key? key,
    required this.availableArchiveLocations,
  }) : super(key: key);

  @override
  State<AvailableArchiveLocationTable> createState() => _AvailableArchiveLocationTableState();
}

class _AvailableArchiveLocationTableState extends State<AvailableArchiveLocationTable> {

  bool sortAscending = true;
  int sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) => TableWrapper(
    sortAscending: sortAscending,
    sortColumnIndex: sortColumnIndex,       
    columnWidthRatio: 0.25,
    headingRowHeight: 35,
    dataListLength: widget.availableArchiveLocations.length,
    columns: [
      ...AvailableArchiveLocationTableColumns.values.map((e) => DataColumn2(
          onSort: (columnIndex, ascending) {
            context.read<AvailableArchiveLocationBloc>().add(AvailableArchiveLocationSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
    source: AvailableArchiveLocationTableData(
      context: context,
      availableArchiveLocations: widget.availableArchiveLocations
    ),
  );
}
