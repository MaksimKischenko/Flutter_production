//DO NOT CHANGE ORDER!!!!
 enum PaymentActionFieldNames {
  fromTime('Дата с'),
  toTime('Дата по'),
  paymentId('ID платежа'),
  fio('ФИО плательщика'),
  passportIn('Идентификационный номер паспорта плательщика'),
  passport('Серия и номер паспорта'),
  address('Адрес плательщика'),
  account('Лицевой счет плательщика'),
  nameSuppplier('Наименование производителя услуги'),  
  accountNumber('Номер расчетного счета производителя услуг'),
  bik('БИК банка расчетного счета производителя услуг'),
  unpSupplier('УНП производителя услуг'),
  code('Код платежа в бюджет'),
  serviceName('Наименование услуги'),
  summMin('Cуммa мин.'),
  summMax('Cуммa макс.'),
  receiptNo('Номер чека'),
  operationNumber('Номер операции во внешней системе'),
  branchNumber('Номер отделения'),
  terminalCode('Код терминала'),
  paymentMethod('Способ оплаты');

  const PaymentActionFieldNames(this.message);
  final String message;
} 



