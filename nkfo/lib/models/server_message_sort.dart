import 'package:data_table_2/data_table_2.dart';

enum ServerMessageSort {
  title, text, creationDate, sendingDate, status
}

extension ServerMessageSortExtension on ServerMessageSort {
  static const Map<ServerMessageSort, String> _sortToDBFieldName = {
    ServerMessageSort.title: 'heading',
    ServerMessageSort.text: 'note',
    ServerMessageSort.creationDate: 'message_date',
    ServerMessageSort.sendingDate: 'sending_date',
    ServerMessageSort.status: 'status',
  };

  // ignore: non_constant_identifier_names
  String get DBName => _sortToDBFieldName[this]!;

  static ServerMessageSort fromDBName(String name) => _sortToDBFieldName.entries.singleWhere((e) => e.value == name).key;

  static const Map<ServerMessageSort, String> _sortToName = {
    ServerMessageSort.title: 'Заголовок',
    ServerMessageSort.text: 'Текст',
    ServerMessageSort.creationDate: 'Дата создания',
    ServerMessageSort.sendingDate: 'Дата отправки',
    ServerMessageSort.status: 'Статус',
  };

  String get name => _sortToName[this]!;

  static const Map<ServerMessageSort, ColumnSize> _sortToColumnSize = {
    ServerMessageSort.title: ColumnSize.M,
    ServerMessageSort.text: ColumnSize.L,
    ServerMessageSort.creationDate: ColumnSize.M,
    ServerMessageSort.sendingDate: ColumnSize.M,
    ServerMessageSort.status: ColumnSize.M,
  };

  ColumnSize get columnSize => _sortToColumnSize[this] ?? ColumnSize.M;
}