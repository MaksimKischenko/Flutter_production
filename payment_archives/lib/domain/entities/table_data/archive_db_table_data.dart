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

class ArchiveDBTableData extends DataTableSource {

  final BuildContext context;
  final List<ArchiveDB> archives;


  ArchiveDBTableData({
    required this.context,
    required this.archives,
  });

  int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => archives.length;

  @override
  int get selectedRowCount => archives.length;
  
  @override
  DataRow2 getRow(int index) => DataRow2(   
    selected: _selectedRow == index,
    onTap: () {
      _selectedRow = index; 
      BlocProvider.of<RowSelectedBloc<ArchiveDB>>(context).add(RowSelectedRun<ArchiveDB>(selectedData: SelectedData<ArchiveDB>(isSelected: true, selectedObject: archives[index])));
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
            BlocProvider.of<RowSelectedBloc<ArchiveDB>>(context).add(RowSelectedRun<ArchiveDB>(selectedData: SelectedData<ArchiveDB>(isSelected: true, selectedObject: archives[index])));
            notifyListeners();
          },
        )
      ), 
      DataCell(Text(archives[index].id.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archives[index].caption ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text((archives[index].createDate ?? DateTime.now()).toStringFormatted(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archives[index].sourceId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(AccessStatusTableItem(value: archives[index].enabled ?? false)),
      DataCell(Text(archives[index].statusId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(archives[index].sourceArchiveId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text((archives[index].partCount ?? 0).toString(), style: AppStyles.tableDataTextStyle))
    ],
  );
}

