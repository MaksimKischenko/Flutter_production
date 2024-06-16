import 'package:data_table_2/data_table_2.dart';

enum ArchiveStatusTableColumns {
  id('ID статуса', ColumnSize.M), 
  caption('Описание статуса', ColumnSize.M);

  final String name;
  final ColumnSize columnSize;

  const ArchiveStatusTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}


 

