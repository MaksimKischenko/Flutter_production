enum PersonalAccountStornoMode{
  beforePayment, onlyToday, forbidden
}

extension PersonalAccountStornoModeExtension on PersonalAccountStornoMode{
  static const Map<PersonalAccountStornoMode, String> _names = {
    //PersonalAccountStornoMode.none: 'Не выбрано',
    PersonalAccountStornoMode.beforePayment: 'Сторнирование разрешено до проведения расчетов',
    PersonalAccountStornoMode.onlyToday: 'Сторнирование разрешено в текущем банковском дне',
    PersonalAccountStornoMode.forbidden: 'Сторнирование запрещено',
  };

  String get name => _names[this] ?? 'Не выбрано';

  static const Map<PersonalAccountStornoMode, String?> _inJson = {
    //PersonalAccountStornoMode.none: '',
    PersonalAccountStornoMode.beforePayment: 'S',
    PersonalAccountStornoMode.onlyToday: 'C',
    PersonalAccountStornoMode.forbidden: 'N',
  };

  String? get inJson => _inJson[this];

  static const Map<String, PersonalAccountStornoMode> _fromName = {
    'S': PersonalAccountStornoMode.beforePayment,
    'C': PersonalAccountStornoMode.onlyToday,
    'N': PersonalAccountStornoMode.forbidden,
  };

  static PersonalAccountStornoMode fromName(String? name) => _fromName[name] ?? PersonalAccountStornoMode.beforePayment;
}