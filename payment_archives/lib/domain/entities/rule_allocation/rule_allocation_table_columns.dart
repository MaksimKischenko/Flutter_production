import 'package:data_table_2/data_table_2.dart';

enum RuleAllocationsTableColumns {
  checkBox('', ColumnSize.S),
  sourceId('Уникальный номер\nисточника', ColumnSize.M),
  storeYear('Год распределения\nданных', ColumnSize.M),
  storeMonth('Месяц распределения\nданных', ColumnSize.M),
  storeDay('День распределения\nданных', ColumnSize.M),
  locationId('Уникальный номер\nБД', ColumnSize.M),
  storeDate('Дата полного\nформата', ColumnSize.M);
  
  final String name;
  final ColumnSize columnSize;

  const RuleAllocationsTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}



