

import 'organizations_status.dart';

class OrganizationInfo {
  final int? eripCode;
  final OrganizationStatus status;
  final String shortName;
  final String? unp;
  final String fullName;
  final String? address;
  final String? email;
  final String? bic;
  final String? accNum;
  final String? abonent;
  final String? contractNumber;
  final String? headFullName;
  final String? headPosition;
  final String? chiefAccountant;
  final String? host;
  final int? port;
  final String? login;
  final String? password;
  OrganizationInfo({
    required this.eripCode,
    required this.status,
    required this.shortName,
    required this.unp,
    required this.fullName,
    required this.address,
    required this.email,
    required this.bic,
    required this.accNum,
    required this.abonent,
    required this.contractNumber,
    required this.headFullName,
    required this.headPosition,
    required this.chiefAccountant,
    required this.host,
    required this.port,
    required this.login,
    required this.password,
  });
  
}
