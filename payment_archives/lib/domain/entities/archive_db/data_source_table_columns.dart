import 'package:data_table_2/data_table_2.dart';

enum DataSourceTableColumns {
  checkBox('', ColumnSize.S),
  id('Уникальный номер\nисточника данных', ColumnSize.M),
  userId('ID пользователя\nисточником данных', ColumnSize.M),
  login('Логин пользователя\nисточником данных', ColumnSize.M),
  createDate('Дата создания', ColumnSize.M),
  caption('Описание источника\nданных', ColumnSize.M),
  dataScale('Справочник масштаба\nданных', ColumnSize.M),
  enabled('Доступность источника\nданных', ColumnSize.M),
  blocked('Блокировка источника\nданных',ColumnSize.M);

  final String name;
  final ColumnSize columnSize;

  const DataSourceTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}



