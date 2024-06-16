import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class ArchiveDBTable extends StatefulWidget {
  final List<ArchiveDB> archives;

  const ArchiveDBTable({
    Key? key,
    required this.archives,
  }) : super(key: key);

  @override
  State<ArchiveDBTable> createState() => _ArchiveDBTableState();
}

class _ArchiveDBTableState extends State<ArchiveDBTable> {

  bool sortAscending = true;
  int sortColumnIndex = 1;  

  @override
  Widget build(BuildContext context) => TableWrapper(
    sortAscending: sortAscending,
    sortColumnIndex: sortColumnIndex,          
    columnWidthRatio: 0.3,
    headingRowHeight: 35,
    dataListLength: widget.archives.length,
    columns: [
      ...ArchiveDBTableColumns.values.map((e) => DataColumn2(
          onSort: (columnIndex, ascending) {
            context.read<ArchiveDbBloc>().add(ArchiveDbSort(ascending: sortAscending, sortIndex: sortColumnIndex));
            setState(() {
              sortAscending = !sortAscending;
              sortColumnIndex = columnIndex;
            });             
          },                  
          size: e.columnSize,
          label: Text(
            e.columnName,
            style: AppStyles.tableHeaderTextStyle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ))
      ),      
    ],
    source: ArchiveDBTableData(
      context: context,
      archives: widget.archives
    ),
  );
}
