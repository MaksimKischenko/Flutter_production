import 'package:data_table_2/data_table_2.dart';

enum ArchivePartTableColumns {
  id('ID архива', ColumnSize.M),
  partId('ID части архива', ColumnSize.M),
  createDate('Дата и время создания\nчасти архива', ColumnSize.M),
  statusId('Статус части\nархива', ColumnSize.M),
  updateDate('Дата последнего изменения\nчасти архива', ColumnSize.M),
  rowCount('Количество записей\nв части архива', ColumnSize.M);
  
  final String name;
  final ColumnSize columnSize;

  const ArchivePartTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}

