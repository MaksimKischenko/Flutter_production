enum JobPartParamActionType {
  edit, delete
}

extension JobPartParamActionTypeExtension on JobPartParamActionType {
  // static const Map<JobPartParamActionType, String> _mapTypeToName = {
  //   JobPartParamActionType.edit : 'Редактировать',
  //   JobPartParamActionType.delete : 'Удалить',
  // };
 
  String name() {
    if (this == JobPartParamActionType.edit) {
      return 'Редактировать';
    } else if (this == JobPartParamActionType.delete) {
      return 'Удалить';
    } 
    return 'Неизвестно';
  }
}