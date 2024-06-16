import 'package:data_table_2/data_table_2.dart';


enum AvailableArchiveLocationTableColumns {
  sourceId('Уникальный номер\nисточника', ColumnSize.M),
  id('Уникальный номер\nархива', ColumnSize.M),
  createDate('Дата создания', ColumnSize.M),
  caption('Описание\nархива', ColumnSize.M),
  connectionHost('Хост расположения\nкластера БД (IP-адрес)', ColumnSize.M),
  connectionPort('Порт хоста', ColumnSize.M),
  connectionUser('Имя пользователя\nдля подключения', ColumnSize.M),
  databaseName('Наименование БД\nв кластере', ColumnSize.M),
  enabled('Доступность БД', ColumnSize.M);

  final String name;
  final ColumnSize columnSize;

  const AvailableArchiveLocationTableColumns(this.name, [this.columnSize = ColumnSize.M]);
}


