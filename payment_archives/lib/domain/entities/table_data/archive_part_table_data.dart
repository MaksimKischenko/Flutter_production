// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';


class ArchivePartTableData extends DataTableSource {

  final BuildContext context;
  final List<ArchiveDBPart> archiveParts;


  ArchivePartTableData({
    required this.context,
    required this.archiveParts,
  });

  final _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => archiveParts.length;

  @override
  int get selectedRowCount => archiveParts.length;
  
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
      DataCell(Text(archiveParts[index].archiveId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveParts[index].partId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveParts[index].createDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveParts[index].statusId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveParts[index].updateDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveParts[index].rowCount.toString(), style: AppStyles.tableDataTextStyle))
    ],
  );
}

