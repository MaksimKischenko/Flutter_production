

enum AccessTypeStatus {
  onlyEdit, onlyRead
}

extension AccessTypeStatusExtension on AccessTypeStatus {
  
  
  static const Map<AccessTypeStatus, String> _names = {
    AccessTypeStatus.onlyEdit: 'Доступен для редактирования',
    AccessTypeStatus.onlyRead: 'Только чтение',
  };

  String? get name => _names[this] ?? '';


  static final Map<AccessTypeStatus, int> _mapToValue = {
    AccessTypeStatus.onlyEdit: 0,
    AccessTypeStatus.onlyRead: 1,
  };

  int? get inJson => _mapToValue[this];


  static final Map<int, AccessTypeStatus> fromJson = {
    0: AccessTypeStatus.onlyEdit,
    1: AccessTypeStatus.onlyRead,
  };

  static AccessTypeStatus fromInt(int? value) => fromJson[value]! ;

}