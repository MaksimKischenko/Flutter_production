import 'package:data_table_2/data_table_2.dart';

enum UserTableColumns {
  checkBox('', ColumnSize.S),
  nameOf('ФИО', ColumnSize.L),
  login('Логин', ColumnSize.M),
  userType('Описание роли', ColumnSize.M),
  blocked('Признак блокировки', ColumnSize.M),
  dateAdd('Дата создания', ColumnSize.M);
  //moreHorize('', ColumnSize.S);
  
  final String name;
  final ColumnSize columnSize;

  const UserTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}



