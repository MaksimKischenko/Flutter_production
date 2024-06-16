class OnlyEntityException  implements Exception {
  String getErrorMessage() => 'Данный кабинет предназначен для юр. лиц';
}

class ClaimQrNotFoundException implements Exception {
  final String cause = 'Требований не найдено';
}

class ClaimQrMissingAccNumException implements Exception {
  final String cause = 'Отсутствует лицевой счет';
}