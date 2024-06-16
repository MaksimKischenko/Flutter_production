enum ParamTypeStatus {
  string, number, doubleNum, logical, data, list
}

extension ParamTypeStatusExtension on ParamTypeStatus{
  static const Map<ParamTypeStatus, String> _names = {
    ParamTypeStatus.string: 'Строка',
    ParamTypeStatus.number: 'Целое число',
    ParamTypeStatus.doubleNum: 'Дробное число',
    ParamTypeStatus.logical : 'Логический',
    ParamTypeStatus.data: 'Дата',
    ParamTypeStatus.list: 'Список'
  };

  String get name => _names[this] ?? '';

  static const Map<ParamTypeStatus, int> _typeToJson = {
    ParamTypeStatus.string: 1,
    ParamTypeStatus.number: 2,
    ParamTypeStatus.doubleNum: 3,
    ParamTypeStatus.logical : 4,
    ParamTypeStatus.data: 5,
    ParamTypeStatus.list: 6
  };

  int get inJson => _typeToJson[this] ?? 0;

  static const Map<int, ParamTypeStatus> _fromName = {
    1:ParamTypeStatus.string,
    2:ParamTypeStatus.number,
    3:ParamTypeStatus.doubleNum,
    4:ParamTypeStatus.logical,
    5:ParamTypeStatus.data,
    6:ParamTypeStatus.list
  };

  static ParamTypeStatus fromInt(int? name) => _fromName[name]!;
}