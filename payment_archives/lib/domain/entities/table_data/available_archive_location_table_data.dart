// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';


class AvailableArchiveLocationTableData extends DataTableSource {

  final BuildContext context;
  final List<AvailableArchiveLocation> availableArchiveLocations;


  AvailableArchiveLocationTableData({
    required this.context,
    required this.availableArchiveLocations,
  });

  final int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => availableArchiveLocations.length;

  @override
  int get selectedRowCount => availableArchiveLocations.length;
  
  @override
  DataRow2 getRow(int index) => DataRow2(    
    selected: _selectedRow == index,
    color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return AppStyles.colorBlue3; 
      } else {
        if(index.isEven) {
          return Colors.transparent;  
        } else {
          return AppStyles.colorGrey3.withOpacity(0.3);
        }
      }
    }),
    cells:[   
      DataCell(Text(availableArchiveLocations[index].sourceId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(availableArchiveLocations[index].id.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(availableArchiveLocations[index].createDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(availableArchiveLocations[index].caption.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(availableArchiveLocations[index].connectionHost ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(availableArchiveLocations[index].connectionPort.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(availableArchiveLocations[index].connectionUser ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(availableArchiveLocations[index].databaseName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(AccessStatusTableItem(value: availableArchiveLocations[index].enabled ?? false)),    
    ],
  );
}

