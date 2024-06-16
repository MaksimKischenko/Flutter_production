import 'package:json_annotation/json_annotation.dart';

part 'information_response.g.dart';

@JsonSerializable()
class PsTpOInformationResponseWrapper {
  @JsonKey(name: 'PS_TP_O')
  final PsTpOInformationResponse psTpO;

  PsTpOInformationResponseWrapper(this.psTpO);

  factory PsTpOInformationResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$PsTpOInformationResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsTpOInformationResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpOInformationResponse {
  @JsonKey(name: 'InformationResponse')
  final InformationResponse response;

  PsTpOInformationResponse(this.response);

  factory PsTpOInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$PsTpOInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOInformationResponseToJson(this);
}

@JsonSerializable()
class InformationResponse {
  @JsonKey(name: 'FullName')
  final String? fullName;

  @JsonKey(name: 'ShortName')
  final String? shortName;

  @JsonKey(name: 'Address')
  final String? address;

  @JsonKey(name: 'MFO')
  final String? mfo;

  @JsonKey(name: 'AccNum')
  final String? accNum;

  @JsonKey(name: 'UNP')
  final String? unp;

  @JsonKey(name: 'FIO')
  final String? fio;

  @JsonKey(name: 'Post')
  final String? post;

  @JsonKey(name: 'Basis')
  final String? basis;

  @JsonKey(name: 'UsersCount')
  final int? usersCount;

  @JsonKey(name: 'ConfirmStatus')
  final int confirmStatus;

  @JsonKey(name: 'PollAvailable')
  final int? pollAvailable;

  @JsonKey(name: 'SupplierId')
  final int? supplierId;

  @JsonKey(name: 'KeyRegistration')
  final String? keyRegistration;

  @JsonKey(name: 'Contact')
  final List<Contact>? contacts;

  @JsonKey(name: 'AccountStatement')
  final InformationResponseAccountStatement? accountStatement;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  InformationResponse({
    required this.fullName,
    this.shortName,
    this.address,
    this.mfo,
    this.accNum,
    this.unp,
    this.fio,
    this.post,
    this.basis,
    this.usersCount,
    required this.confirmStatus,
    this.pollAvailable,
    required this.supplierId,
    this.keyRegistration,
    this.contacts,
    this.accountStatement,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory InformationResponse.fromJson(Map<String, dynamic> json) =>
      _$InformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InformationResponseToJson(this);
}

@JsonSerializable()
class Contact {
  @JsonKey(name: 'Contact')
  final String contact;

  @JsonKey(name: 'Position')
  final String position;

  @JsonKey(name: 'Phone')
  final String phone;

  Contact({
    required this.contact,
    required this.position,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

@JsonSerializable()
class InformationResponseAccountStatement {
  @JsonKey(name: 'Account')
  final List<InformationResponseAccountStatementAccount>? accounts;

  InformationResponseAccountStatement({this.accounts});

  factory InformationResponseAccountStatement.fromJson(
          Map<String, dynamic> json) =>
      _$InformationResponseAccountStatementFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InformationResponseAccountStatementToJson(this);
}

@JsonSerializable()
class InformationResponseAccountStatementAccount {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@MFO')
  final String mfo;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@AccountSystem')
  final String accountSystem;

  InformationResponseAccountStatementAccount({
    required this.evalue,
    required this.mfo,
    required this.name,
    required this.accountSystem,
  });

  factory InformationResponseAccountStatementAccount.fromJson(
          Map<String, dynamic> json) =>
      _$InformationResponseAccountStatementAccountFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InformationResponseAccountStatementAccountToJson(this);
}
