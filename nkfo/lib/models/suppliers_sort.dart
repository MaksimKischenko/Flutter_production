import 'package:data_table_2/data_table_2.dart';

enum SuppliersSort {
  unp, shortName, outSupplierCode, address, bic, accountNumber, abonent, contractNumber, status
}

extension SuppliersSortExtension on SuppliersSort {
  static const Map<SuppliersSort, String> _sortToDBFieldName = {
    SuppliersSort.unp: 'supplier_unp',
    SuppliersSort.shortName: 'supplier_shortname',
    SuppliersSort.outSupplierCode: 'out_supplier_code',
    SuppliersSort.address: 'supplier_domicile',
    SuppliersSort.bic: 'bank_bic',
    SuppliersSort.accountNumber: 'account',
    SuppliersSort.abonent: 'abonent',
    SuppliersSort.contractNumber: 'contract',
    SuppliersSort.status: 'enabled'
  };

  // ignore: non_constant_identifier_names
  String get DBName => _sortToDBFieldName[this]!;

  static SuppliersSort fromDBName(String name) => _sortToDBFieldName.entries.singleWhere((e) => e.value == name).key;

  static const Map<SuppliersSort, String> _sortToName = {
    SuppliersSort.unp: 'УНП',
    SuppliersSort.shortName: 'Краткое наименование',
    SuppliersSort.outSupplierCode: 'Код (ЕРИП)',
    SuppliersSort.address: 'Юридический адрес',
    SuppliersSort.bic: 'БИК банка',
    SuppliersSort.accountNumber: 'Номер счета',
    SuppliersSort.abonent: 'Абонент',
    SuppliersSort.contractNumber: 'Номер договора',
    SuppliersSort.status: 'Статус'
  };

  String get name => _sortToName[this]!;

  static const Map<SuppliersSort, ColumnSize> _sortToColumnSize = {
    SuppliersSort.unp: ColumnSize.M,
    SuppliersSort.shortName: ColumnSize.L,
    SuppliersSort.outSupplierCode: ColumnSize.M,
    SuppliersSort.address: ColumnSize.L,
    SuppliersSort.bic: ColumnSize.M,
    SuppliersSort.accountNumber: ColumnSize.L,
    SuppliersSort.abonent: ColumnSize.M,
    SuppliersSort.contractNumber: ColumnSize.M,
    SuppliersSort.status: ColumnSize.M
  };

  ColumnSize get columnSize => _sortToColumnSize[this] ?? ColumnSize.M;
}