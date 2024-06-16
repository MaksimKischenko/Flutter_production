enum DataSourceActionFieldNames {
  date('Дата создания'),
  login('Логин пользователя источником данных'),
  password('Пароль'),
  dataScale('Масштаб данных'),
  caption('Описание источника данных'),
  enable('Доступ разрешен'),
  blocked('Заблокирован');

  const DataSourceActionFieldNames(this.message);
  final String message;
}
