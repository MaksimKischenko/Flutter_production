enum SupplierStatus {
  all, enabled, disabled
}

extension SupplierStatusExtension on SupplierStatus {
  static final Map<SupplierStatus, String> _mapNameForFilter = {
    SupplierStatus.all: 'Все',
    SupplierStatus.enabled: 'Подключен',
    SupplierStatus.disabled: 'Отключен',
  };

  String get name => _mapNameForFilter[this]!;


  static final Map<SupplierStatus, bool> _mapToBool = {
    SupplierStatus.enabled: true,
    SupplierStatus.disabled: false
  };

  bool? get boolean => _mapToBool[this];
}