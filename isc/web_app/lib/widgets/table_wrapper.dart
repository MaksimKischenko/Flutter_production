// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';



class TableWrapper extends StatelessWidget {
  final double headingRowHeight;
  final double? dataRowHeight;
  final int dataListLength;
  final List<DataColumn> columns;
  final DataTableSource source;
  final bool sortAscending;
  final int sortColumnIndex;

  const TableWrapper({
    Key? key,
    required this.headingRowHeight,
    required this.dataListLength,
    required this.columns,
    required this.source,
    this.sortAscending = true,
    this.dataRowHeight,
    this.sortColumnIndex = 1
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: WebPaginatedTableCustom(
          wrapInCard: true,
          sortAscending: sortAscending,
          sortColumnIndex: sortColumnIndex,
          sortArrowAnimationDuration: const Duration(milliseconds: 500),
          columns: columns,
          horizontalMargin: 0,
          lmRatio: 5,
          smRatio: 0.2, //ширина
          columnSpacing: 4, //ширина
          dataRowHeight: dataRowHeight ?? 30,
          dividerThickness: 0,
          headingRowHeight: headingRowHeight,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) => AppStyles.headingRowColor),
          //empty: Center(child: Text('Данных нет', style: AppStyles.emptyTableStyle)),           
          border: TableBorder.all(width: 1, color: Colors.white),
          rowsPerPage: 20,
          showFirstLastButtons: true,
          renderEmptyRowsInTheEnd: false,
          source: source
    ));
}
