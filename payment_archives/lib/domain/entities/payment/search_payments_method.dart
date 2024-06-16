enum SearchPaymentMethod {
  full('Весь список'),
  ids('Список ID Платежей ЕРИП'),
  names('Список ФИО'),;

  const SearchPaymentMethod(this.name);
  final String name;
}
