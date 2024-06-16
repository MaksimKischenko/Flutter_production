// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';


class ArchiveLocationTableData extends DataTableSource {

  final BuildContext context;
  final List<ArchiveLocation> archiveLocations;


  ArchiveLocationTableData({
    required this.context,
    required this.archiveLocations,
  });

  int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => archiveLocations.length;

  @override
  int get selectedRowCount => archiveLocations.length;
  
  @override
  DataRow2 getRow(int index) => DataRow2(   
    selected: _selectedRow == index,
    onTap: () {
      _selectedRow = index; 
      BlocProvider.of<RowSelectedBloc<ArchiveLocation>>(context).add(RowSelectedRun<ArchiveLocation>(selectedData: SelectedData<ArchiveLocation>(isSelected: true, selectedObject: archiveLocations[index])));          
      notifyListeners();
    },    
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
      DataCell(
        SelectBox(
          value: _selectedRow == index,
          onChanged: (value) {
            _selectedRow = index; 
            BlocProvider.of<RowSelectedBloc<ArchiveLocation>>(context).add(RowSelectedRun<ArchiveLocation>(selectedData: SelectedData<ArchiveLocation>(isSelected: true, selectedObject: archiveLocations[index])));          
            notifyListeners();
          },
        )
      ),          
      DataCell(Text('${archiveLocations[index].id}', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveLocations[index].createDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveLocations[index].caption.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveLocations[index].connectionHost ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveLocations[index].connectionPort.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveLocations[index].connectionUser ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archiveLocations[index].databaseName ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(AccessStatusTableItem(value: archiveLocations[index].enabled ?? false)),   
    ],
  );
}

