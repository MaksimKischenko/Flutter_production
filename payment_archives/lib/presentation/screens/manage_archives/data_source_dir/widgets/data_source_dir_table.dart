import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class DataSourceDirTable extends StatefulWidget {
  final List<DataSource> dataSources;

  const DataSourceDirTable({
    Key? key,
    required this.dataSources,
  }) : super(key: key);

  @override
  State<DataSourceDirTable> createState() => _DataSourceDirTableState();
}

class _DataSourceDirTableState extends State<DataSourceDirTable> {

  bool sortAscending = true;
  int sortColumnIndex = 1;

  @override
  Widget build(BuildContext context) => TableWrapper(
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,      
      columnWidthRatio: 0.25,
      headingRowHeight: 35,
      dataListLength: widget.dataSources.length,
      columns: [
        ...DataSourceTableColumns.values.map((e) => DataColumn2(
            onSort: (columnIndex, ascending) {
              context.read<DataSourceBloc>().add(DataSourceSort(ascending: sortAscending, sortIndex: sortColumnIndex));
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
            )
          ))
      ],
      source: DataSourceTableData(
        context: context,
        dataSources: widget.dataSources
      ),
    );
}
