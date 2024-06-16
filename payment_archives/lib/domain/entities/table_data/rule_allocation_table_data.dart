import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class RuleAllocationTableData extends DataTableSource {

  final BuildContext context;
  final List<RuleAllocationData> ruleAllocations;

  RuleAllocationTableData({
    required this.context,
    required this.ruleAllocations,
  });

  int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => ruleAllocations.length;

  @override
  int get selectedRowCount => ruleAllocations.length;
  
  @override
  DataRow2 getRow(int index) => DataRow2(    
    selected: _selectedRow == index,
    onTap: () {
      _selectedRow = index; 
      BlocProvider.of<RowSelectedBloc<RuleAllocationData>>(context).add(RowSelectedRun<RuleAllocationData>(selectedData: SelectedData<RuleAllocationData>(isSelected: true, selectedObject: ruleAllocations[index])));            
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
            BlocProvider.of<RowSelectedBloc<RuleAllocationData>>(context).add(RowSelectedRun<RuleAllocationData>(selectedData: SelectedData<RuleAllocationData>(isSelected: true, selectedObject: ruleAllocations[index])));            
            notifyListeners();
          },
        )
      ),      
      DataCell(Text(ruleAllocations[index].sourceId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(ruleAllocations[index].storeYear.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(ruleAllocations[index].storeMonth?.toString() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(ruleAllocations[index].storeDay?.toString() ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(ruleAllocations[index].locationId.toString(), style: AppStyles.tableDataTextStyle)),
      DataCell(Text(ruleAllocations[index].storeDate ?? '', style: AppStyles.tableDataTextStyle)),
    ],
  );
}

