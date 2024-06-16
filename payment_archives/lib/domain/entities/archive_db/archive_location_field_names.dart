enum ArchiveLocationActionFieldNames {
  date('Дата создания'),
  caption('Описание архива'),
  host('Хост расположения кластера БД (IP-адрес)'),
  port('Порт хоста'),
  name('Имя пользователя для подключения'),
  nameBD('Наименование БД в кластере'),
  enable('Доступность БД');

  const ArchiveLocationActionFieldNames(this.message);
  final String message;
}
