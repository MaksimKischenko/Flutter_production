import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class MapAllocationTable extends StatefulWidget {
  final List<MapAllocationData> mapAllocations;

  const MapAllocationTable({
    Key? key,
    required this.mapAllocations,
  }) : super(key: key);

  @override
  State<MapAllocationTable> createState() => _MapAllocationTableState();
}

class _MapAllocationTableState extends State<MapAllocationTable> {
  bool sortAscending = true;
  int sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) => TableWrapper(
    sortAscending: sortAscending,
    sortColumnIndex: sortColumnIndex,      
    columnWidthRatio: 0.20,
    headingRowHeight: 35,
    dataListLength: widget.mapAllocations.length,
    columns: [
    ...MapAllocationTableColumns.values.map((e) => DataColumn2(
        onSort: (columnIndex, ascending) {
          context.read<MapAllocationBloc>().add(MapAllocationSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
    source: MapAllocationTableData(
      context: context,
      mapAllocations: widget.mapAllocations
    ),
  );
}
