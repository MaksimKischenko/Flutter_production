import 'package:data_table_2/data_table_2.dart';

enum MapAllocationTableColumns {
  id('Уникальный номер\nархива', ColumnSize.M),
  locationId('Уникальный номер БД', ColumnSize.M),
  enabled('Доступность', ColumnSize.M),
  storeDate('Дата данных', ColumnSize.M);

  final String name;
  final ColumnSize columnSize;

  const MapAllocationTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}

