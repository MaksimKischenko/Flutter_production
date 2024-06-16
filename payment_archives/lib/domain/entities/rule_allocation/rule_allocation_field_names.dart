enum RuleAllocationActionFieldNames {
  source('Выбор источника данных'),
  loction('Выбор приемника данных'),
  year('Год распределения данных'),
  month('Месяц распределения данных'),
  isDefault('Правило по умолчанию'),
  day('День распределения данных');

  const RuleAllocationActionFieldNames(this.message);
  final String message;
}
