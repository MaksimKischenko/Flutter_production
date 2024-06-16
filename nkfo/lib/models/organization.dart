import 'organizations_status.dart';

class Organization {
  final String unp;
  final String shortName;
  final int eripCode;
  final String address;
  final String bic;
  final String accNum;
  final String abonent;
  final String contractNumber;
  final OrganizationStatus status;

  Organization({
    required this.unp,
    required this.shortName,
    required this.eripCode,
    required this.address,
    required this.bic,
    required this.accNum,
    required this.abonent,
    required this.contractNumber,
    required this.status,
  });
  
}