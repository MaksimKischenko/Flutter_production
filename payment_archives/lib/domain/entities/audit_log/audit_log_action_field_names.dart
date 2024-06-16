enum AuditLogActionFieldNames {
  dateFrom('Дата с'),
  timeFrom('Время с'),
  dateTo('Дата по'),
  timeTo('Время по'),
  userName('Имя пользователя');

  const AuditLogActionFieldNames(this.message);
  final String message;
}
