enum UserActionType {
  block, resetPassword
}

extension UserActionTypeExtension on UserActionType {
  String name({required bool blocked}) {
    if (this == UserActionType.block) {
      return blocked ? 'Разблокировать' : 'Заблокировать';
    } else if (this == UserActionType.resetPassword) {
      return 'Сбросить пароль';
    }
    return 'Неизвестно';
  }
}