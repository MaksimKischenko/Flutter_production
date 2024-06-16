import 'package:isc_web_app/widgets/widgets.dart';

enum PaymentsTableColumns { 
  accNum('№ счета\nплательщика', ColumnSize.L), 
  memNumber('№ платежного\nдокумента', ColumnSize.L), 
  memDate('Дата перечисления', ColumnSize.L), 
  fio('ФИО', ColumnSize.L),     
  id('Код платежа', ColumnSize.L), 
  paymentDate('Дата платежа', ColumnSize.L),   
  paymentSum('Сумма платежа', ColumnSize.L), 
  claimId('Код требования', ColumnSize.L),
  status('Статус', ColumnSize.L);

  const PaymentsTableColumns(this.columnName, this.columnSize);
  final String columnName;  
  final ColumnSize columnSize;
}

