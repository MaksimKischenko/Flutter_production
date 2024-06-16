import 'package:data_table_2/data_table_2.dart';

enum UsersSort {
  name, login, email, phoneNumber, role, supplierUnp, supplierName, blocked, dateAdd
}

extension UsersSortExtension on UsersSort {
  static const Map<UsersSort, String> _sortToDBFieldName = {
    UsersSort.name: 'name',
    UsersSort.login: 'login',
    UsersSort.email: 'email',
    UsersSort.phoneNumber: 'phone_number',
    UsersSort.role: 'type_id',
    UsersSort.supplierUnp: 'supplier_unp',
    UsersSort.supplierName: 'supplier_name',
    UsersSort.blocked: 'blocked',
    UsersSort.dateAdd: 'date_add'
  };

  // ignore: non_constant_identifier_names
  String get DBName => _sortToDBFieldName[this]!;

  static UsersSort fromDBName(String name) => _sortToDBFieldName.entries.singleWhere((e) => e.value == name).key;

  static const Map<UsersSort, String> _sortToName = {
    UsersSort.name: 'ФИО',
    UsersSort.login: 'Логин',
    UsersSort.email: 'E-mail',
    UsersSort.phoneNumber: 'Телефон',
    UsersSort.role: 'Роль',
    UsersSort.supplierUnp: 'УНП',
    UsersSort.supplierName: 'Организация',
    UsersSort.blocked: 'Признак блокировки',
    UsersSort.dateAdd: 'Дата создания'
  };

  String get name => _sortToName[this]!;

  static const Map<UsersSort, ColumnSize> _sortToColumnSize = {
    UsersSort.name: ColumnSize.M,
    UsersSort.login: ColumnSize.M,
    UsersSort.email: ColumnSize.M,
    UsersSort.phoneNumber: ColumnSize.M,
    UsersSort.role: ColumnSize.M,
    UsersSort.supplierUnp: ColumnSize.M,
    UsersSort.supplierName: ColumnSize.M,
    UsersSort.blocked: ColumnSize.M,
    UsersSort.dateAdd: ColumnSize.M,
  };

  ColumnSize get columnSize => _sortToColumnSize[this] ?? ColumnSize.M;
}