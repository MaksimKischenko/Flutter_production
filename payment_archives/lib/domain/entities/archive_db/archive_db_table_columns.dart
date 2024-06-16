import 'package:data_table_2/data_table_2.dart';

enum ArchiveDBTableColumns {
  checkBox('', ColumnSize.S), 
  id('ID архива', ColumnSize.M), 
  name('Наименование\nархива', ColumnSize.M), 
  startDate('Дата и время\nсоздания архива', ColumnSize.M), 
  sourceId('ID источника\nсоздавшего архив', ColumnSize.M,), 
  enabled('Доступность\nархива', ColumnSize.M), 
  statusId('Статус\nархива', ColumnSize.M), 
  sourceArchiveId('Уникальный номер\nархива у источника', ColumnSize.M), 
  partCount('Общее количество\nчастей архива', ColumnSize.M); 

  const ArchiveDBTableColumns(this.columnName, this.columnSize);
  final String columnName;  
  final ColumnSize columnSize;
}



