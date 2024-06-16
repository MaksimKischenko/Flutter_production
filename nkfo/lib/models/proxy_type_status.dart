

enum ProxyTypeStatus {
  none, httpWithFtp, open, site, tranparent, userPass, userSite
}

extension ProxyTypeStatusExtension on ProxyTypeStatus {
  
  
  static const Map<ProxyTypeStatus, String> _names = {
    ProxyTypeStatus.none: 'None',
    ProxyTypeStatus.httpWithFtp: 'HttpProxyWithFTP',
    ProxyTypeStatus.open: 'Open',
    ProxyTypeStatus.site: 'Site',
    ProxyTypeStatus.tranparent: 'Tranparent',
    ProxyTypeStatus.userPass: 'UserPass',
    ProxyTypeStatus.userSite: 'UserSite',
  };

  String? get name => _names[this] ?? '';

  static final Map<ProxyTypeStatus, int> _mapToValue = {
    ProxyTypeStatus.none: -1,
    ProxyTypeStatus.httpWithFtp: 0,
    ProxyTypeStatus.open: 1,
    ProxyTypeStatus.site: 2,
    ProxyTypeStatus.tranparent: 3,
    ProxyTypeStatus.userPass: 4,
    ProxyTypeStatus.userSite: 5,
  };

  int? get inJson => _mapToValue[this];


  static final Map<int, ProxyTypeStatus> fromJson = {
    -1: ProxyTypeStatus.none,
    0: ProxyTypeStatus.httpWithFtp,
    1: ProxyTypeStatus.open,
    2: ProxyTypeStatus.site,
    3: ProxyTypeStatus.tranparent,
    4: ProxyTypeStatus.userPass,
    5: ProxyTypeStatus.userSite
  };

  static ProxyTypeStatus fromInt(int? value) => fromJson[value]! ;
}