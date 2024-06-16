enum UserActionFieldNames {
  date('Дата создания'),
  name('ФИО'),
  login('Логин'),
  password('Пароль'),
  role('Тип пользователя'),
  resetPassword('Сменить пароль'),  
  enable('Заблокирован');

  const UserActionFieldNames(this.message);
  final String message;
}
