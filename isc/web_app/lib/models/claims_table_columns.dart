

import 'package:isc_web_app/widgets/widgets.dart';

enum ClaimsTableColumns { 
  claimCode('Код требования', ColumnSize.L), 
  accountName('Номер счета', ColumnSize.L), 
  invoiceDate('Выставлено', ColumnSize.L), 
  dueDate('Срок оплаты', ColumnSize.L), 
  fio('ФИО', ColumnSize.L),   
  summ('Сумма', ColumnSize.L), 
  paySumm('Сумма оплаты', ColumnSize.L), 
  status('Статус', ColumnSize.L);

  const ClaimsTableColumns(this.columnName, this.columnSize);
  final String columnName;  
  final ColumnSize columnSize;
}

