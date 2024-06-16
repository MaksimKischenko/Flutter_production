enum PersonalAccountValueType {
  none, number, string, date, _double, logical
}

extension PersonalAccountValueTypeExtension on PersonalAccountValueType{
  static const Map<PersonalAccountValueType, String> _names = {
    PersonalAccountValueType.none: 'Не выбрано',
    PersonalAccountValueType.number: 'Число',
    PersonalAccountValueType.string: 'Строка',
    PersonalAccountValueType.date: 'Дата',
    PersonalAccountValueType._double : 'Дробное число через точку',
    PersonalAccountValueType.logical: 'Логическое'
  };

  String get name => _names[this] ?? 'Не выбрано';

  static const Map<PersonalAccountValueType, String> _typeToJson = {
    PersonalAccountValueType.number: 'I',
    PersonalAccountValueType.string: 'S',
    PersonalAccountValueType.date: 'D',
    PersonalAccountValueType._double : 'R',
    PersonalAccountValueType.logical: 'L'
  };

  String get inJson => _typeToJson[this] ?? 'S';

  static const Map<String, PersonalAccountValueType> _fromName = {
    'I': PersonalAccountValueType.number,
    'S': PersonalAccountValueType.string,
    'D': PersonalAccountValueType.date,
    'R': PersonalAccountValueType._double,
    'L': PersonalAccountValueType.logical
  };

  static PersonalAccountValueType fromName(String? name) => _fromName[name] ?? PersonalAccountValueType.string;
}