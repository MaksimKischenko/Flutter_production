import 'package:data_table_2/data_table_2.dart';


enum PaymentTableColumns {
  fio('ФИО\nплательщика', ColumnSize.M),
  adress('Адрес\nплательщика', ColumnSize.M),
  fullNameDepositor('ФИО\nвносителя', ColumnSize.M),
  depositorAddress('Адрес\nвносителя', ColumnSize.M),
  supplierName('Наименование\nпоставщика', ColumnSize.M),
  serviceName('Услуга', ColumnSize.M),
  supplierAccount('Счет\nпоставщика', ColumnSize.M),
  bankName('Банк', ColumnSize.M),
  bik('БИК', ColumnSize.M),
  budgetCode('Код платежа\nв бюджет', ColumnSize.M),
  paySum('Сумма без пени\nи комиссии', ColumnSize.M),
  commissionSum('Сумма\nкомиссии', ColumnSize.M),
  penaltySum('Сумма\nпени', ColumnSize.M),
  terminalId('Код\nтерминала', ColumnSize.M),
  terminalDept('№ отделения', ColumnSize.M),
  deptFilial('Филиал', ColumnSize.M),
  terminalLocation('Адресс\nтерминала', ColumnSize.M),
  receiptNo('№ чека', ColumnSize.M),
  operationNo('№ операции\nво внешней\nсистеме', ColumnSize.M),
  payDate('Дата\nплатежа', ColumnSize.M),
  consolidatedDocDate('Дата сводного\nдокумента', ColumnSize.M),
  consolidatedDocId('№ сводного\nдокумента', ColumnSize.M),
  consolidatedDocPay('Назначение\nсводного\nдокумента', ColumnSize.M),
  consolidatedExportFileName('Имя файла\nвыгрузки в ОДБ', ColumnSize.M), 
  region('Регион', ColumnSize.M),
  paymentMethod('Способ\nоплаты', ColumnSize.M);

  final String name;
  final ColumnSize columnSize;

  const PaymentTableColumns(this.name, this.columnSize);
}
