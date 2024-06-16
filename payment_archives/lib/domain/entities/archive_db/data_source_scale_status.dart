enum DataSourceScaleStatus {
  day('День', 1),
  month('Месяц', 2),
  year('Год', 3);

  const DataSourceScaleStatus(this.message, this.dataScale);
  final String message;
  final int dataScale;
}
