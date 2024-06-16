
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';


class DataSourceTableData extends DataTableSource {

  final BuildContext context;
  final List<DataSource> dataSources;


  DataSourceTableData({
    required this.context,
    required this.dataSources,
  });

  int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataSources.length;

  @override
  int get selectedRowCount => dataSources.length;
  
  @override
  DataRow2 getRow(int index) => DataRow2(    
    selected: _selectedRow == index,
    onTap: () {
      _selectedRow = index; 
      BlocProvider.of<RowSelectedBloc<DataSource>>(context).add(RowSelectedRun<DataSource>(selectedData: SelectedData<DataSource>(isSelected: true, selectedObject: dataSources[index])));
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
            BlocProvider.of<RowSelectedBloc<DataSource>>(context).add(RowSelectedRun<DataSource>(selectedData: SelectedData<DataSource>(isSelected: true, selectedObject: dataSources[index])));
            notifyListeners();
          },
        )
      ),        
      DataCell(Text(dataSources[index].id.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(dataSources[index].userId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(dataSources[index].login.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(dataSources[index].createDate?.toStringFormatted() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(dataSources[index].caption.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(dataSources[index].dataScalePeriod(), style: AppStyles.tableDataTextStyle)),
      DataCell(AccessStatusTableItem(value: dataSources[index].enabled ?? false)),    
      DataCell(AccessStatusTableItem(isAboutBlocking: true, value: dataSources[index].blocked ?? false)),
    ],
  );
}

