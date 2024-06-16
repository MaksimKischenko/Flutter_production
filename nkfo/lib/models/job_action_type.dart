enum JobActionType {
  edit, delete, run
}

extension JobActionTypeExtension on JobActionType {
  String name() {
    if (this == JobActionType.edit) {
      return 'Редактировать';
    } else if (this == JobActionType.delete) {
      return 'Удалить';
    } else if (this == JobActionType.run) {
      return 'Выполнить';
    }
    return 'Неизвестно';
  }
}