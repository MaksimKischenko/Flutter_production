import 'package:data_table_2/data_table_2.dart';

enum AuditLogTableColumns {
  logId('Учетный номер\nзаписи', ColumnSize.M),
  userId('ID\nпользователя', ColumnSize.M),
  userName('Логин\nпользователя', ColumnSize.M),
  userFullName('Полное имя\nпользователя', ColumnSize.M),
  date('Дата и время', ColumnSize.M),
  actionId('Тип действия', ColumnSize.M),
  actionDescription('Описание\nдействия', ColumnSize.M),
  ip('IP адрес', ColumnSize.M);
  
  final String name;
  final ColumnSize columnSize;

  const AuditLogTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}


