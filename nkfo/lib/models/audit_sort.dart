import 'package:data_table_2/data_table_2.dart';

enum AuditSort {
  date, action, application, clientLogin, clientName, supplierName, description
}

extension AuditSortExtension on AuditSort {
  static const Map<AuditSort, String> _sortToDBFieldName = {
    AuditSort.date: 'op_action_date',
    AuditSort.action: 'op_action_code',
    AuditSort.application: 'action_arm',
    AuditSort.clientLogin: 'client_login',
    AuditSort.clientName: 'client_name',
    AuditSort.supplierName: 'supplier_name',
    AuditSort.description: 'op_descr',
  };

  // ignore: non_constant_identifier_names
  String get DBName => _sortToDBFieldName[this]!;

  static AuditSort fromDBName(String name) => _sortToDBFieldName.entries.singleWhere((e) => e.value == name).key;

  static const Map<AuditSort, String> _sortToName = {
    AuditSort.date: 'Дата',
    AuditSort.action: 'Событие',
    AuditSort.application: 'Приложение',
    AuditSort.clientLogin: 'Логин',
    AuditSort.clientName: 'ФИО',
    AuditSort.supplierName: 'Организация',
    AuditSort.description: 'Описание',
  };

  String get name => _sortToName[this]!;
  
  static const Map<AuditSort, ColumnSize> _sortToColumnSize = {
    AuditSort.date: ColumnSize.M,
    AuditSort.action: ColumnSize.M,
    AuditSort.application: ColumnSize.M,
    AuditSort.clientLogin: ColumnSize.M,
    AuditSort.clientName: ColumnSize.M,
    AuditSort.supplierName: ColumnSize.M,
    AuditSort.description: ColumnSize.L,
  };

  ColumnSize get columnSize => _sortToColumnSize[this] ?? ColumnSize.M;
}