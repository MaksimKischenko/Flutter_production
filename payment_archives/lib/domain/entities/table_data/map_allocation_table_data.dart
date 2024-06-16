// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';



class MapAllocationTableData extends DataTableSource {

  final BuildContext context;
  final List<MapAllocationData> mapAllocations;


  MapAllocationTableData({
    required this.context,
    required this.mapAllocations,
  });

  final int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => mapAllocations.length;

  @override
  int get selectedRowCount => mapAllocations.length;
  
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
      DataCell(Text(mapAllocations[index].archiveId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(mapAllocations[index].locationId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(AccessStatusTableItem(value: mapAllocations[index].enabled ?? false)),  
      DataCell(Text(mapAllocations[index].storeDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
    ],
  );
}

