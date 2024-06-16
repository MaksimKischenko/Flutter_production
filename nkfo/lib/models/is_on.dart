enum IsOnOfStatus {
   isOn, isOff
}

extension IsOnOfStatusExtension on IsOnOfStatus {
  static const Map<IsOnOfStatus, String> _names = {
    IsOnOfStatus.isOn: 'Включено',
    IsOnOfStatus.isOff: 'Выключено',
    

  };

  String get name => _names[this] ?? 'Неизвестно';

  static final Map<IsOnOfStatus, String> _mapToInt = {
    IsOnOfStatus.isOn: '1',
    IsOnOfStatus.isOff: '0',
  };

  String? get ints => _mapToInt[this];

  static final Map<String, IsOnOfStatus> _fromInt = {
    '1': IsOnOfStatus.isOn,
    '0': IsOnOfStatus.isOff
    
  };

  static IsOnOfStatus fromInt(String? value) => _fromInt[value] ?? IsOnOfStatus.isOff;

}