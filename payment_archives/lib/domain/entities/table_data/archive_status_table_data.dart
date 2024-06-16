// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class ArchiveStatusTableData extends DataTableSource {

  final BuildContext context;
  final List<ArchiveStatus> archiveStatuses;


  ArchiveStatusTableData({
    required this.context,
    required this.archiveStatuses,
  });

  final int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => archiveStatuses.length;

  @override
  int get selectedRowCount => archiveStatuses.length;
  
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
      DataCell(Text(archiveStatuses[index].id.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveStatuses[index].caption, style: AppStyles.tableDataTextStyle)),
    ],
  );
}

