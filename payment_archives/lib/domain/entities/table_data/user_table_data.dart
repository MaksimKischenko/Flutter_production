import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';

class UserTableData extends DataTableSource {

  final BuildContext context;
  final List<User> users;
  final isUsersViewer = getIt<DataManager>().tokendata?.userType == UserTypeRoleById.userViewer;

  UserTableData({
    required this.context,
    required this.users,
  });

  int _selectedRow = -1;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => users.length;
  
  @override
  DataRow2 getRow(int index) => DataRow2(    
    selected: _selectedRow == index,
    onTap: () {
      _selectedRow = index; 
      BlocProvider.of<RowSelectedBloc<User>>(context).add(RowSelectedRun<User>(selectedData: SelectedData<User>(isSelected: true, selectedObject: users[index])));
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
        isUsersViewer? const SizedBox.shrink():
        SelectBox(
          value: _selectedRow == index,
          onChanged: (value) {
            _selectedRow = index; 
            BlocProvider.of<RowSelectedBloc<User>>(context).add(RowSelectedRun<User>(selectedData: SelectedData<User>(isSelected: true, selectedObject: users[index])));
            notifyListeners();
          },
        )
      ),
      DataCell(Text(users[index].name ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(users[index].login ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(Text(users[index].type?.name ?? '', style: AppStyles.tableDataTextStyle)),
      DataCell(AccessStatusTableItem(isAboutBlocking: true, value: users[index].blocked ?? false)),
      DataCell(Text(users[index].dateAdd?.toStringFormattedRunOperation() ?? '' , style: AppStyles.tableDataTextStyle)),
      // DataCell(UsersActionPopUp(
      //   user: users[index],
      //   onBlock: () {},
      //   onReset: () {},
      // )),      
    ],
  );
}

