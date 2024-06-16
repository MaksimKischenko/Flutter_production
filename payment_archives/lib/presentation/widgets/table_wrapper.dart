// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/paginated_table.dart';


class TableWrapper extends StatelessWidget {
  final double columnWidthRatio;
  final double headingRowHeight;
  final double? dataRowHeight;
  final int dataListLength;
  final List<DataColumn> columns;
  final DataTableSource source;
  final bool sortAscending;
  final bool canZoom;
  final Widget? additionalElements;
  final int sortColumnIndex;

  const TableWrapper({
    Key? key,
    required this.columnWidthRatio,
    required this.headingRowHeight,
    required this.dataListLength,
    required this.columns,
    required this.source,
    this.additionalElements,
    this.sortAscending = true,
    this.canZoom = false,
    this.dataRowHeight,
    this.sortColumnIndex = 0
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: PaginatedTable(
          wrapInCard: false,
          canZoom: canZoom,
          additionalElements: additionalElements,
          sortAscending: sortAscending,
          sortColumnIndex: sortColumnIndex,
          sortArrowAnimationDuration: const Duration(milliseconds: 500),
          columns: columns,
          smRatio: columnWidthRatio, //ширина
          columnSpacing: 10, //ширина
          dataRowHeight: dataRowHeight ?? 30,
          dividerThickness: 0,
          headingRowHeight: headingRowHeight,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) => AppStyles.colorGold),
          empty: Center(child: Text('Данных нет', style: AppStyles.headerStyle)),  
          //border: TableBorder(verticalInside: BorderSide(width: 0.5, color: Colors.white)),  //TableBorder.symmetric(inside: BorderSide(width: 0.5, color: AppStyles.colorWhite.withOpacity(0.5))),           
          //border: TableBorder.all(width: 0.7, color: AppStyles.colorGold),
          rowsPerPage: 20, //generateTableRowsPerPage(),//dataListLength, //<= 5? 5 : 10,
          showFirstLastButtons: true,
          source: source
    ));
  

  int generateTableRowsPerPage() {
    var rowsCount = 0;
    if(dataListLength <= 5) {
      rowsCount = 5;
    } else if(6 < dataListLength && dataListLength < 20) {
      rowsCount = 10;
    } else {
      rowsCount = 20;
    }
    return rowsCount;
  }
}
