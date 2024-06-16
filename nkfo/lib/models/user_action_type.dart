enum UserActionType {
  edit, block, delete, resetPassword
}

extension UserActionTypeExtension on UserActionType {
  
  String name({required bool blocked}) {
    if (this == UserActionType.edit) {
      return 'Редактировать';
    } else if (this == UserActionType.block) {
      return blocked ? 'Разблокировать' : 'Заблокировать';
    } else if (this == UserActionType.delete) {
      return 'Удалить';
    } else if (this == UserActionType.resetPassword) {
      return 'Сбросить пароль';
    }
    return 'Неизвестно';
  }
}