// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'add_claim_request.g.dart';

@JsonSerializable()
class PsTpOAddClaimRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOAddClaimRequest psTpO;

  PsTpOAddClaimRequestWrapper(this.psTpO);

  factory PsTpOAddClaimRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOAddClaimRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAddClaimRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOAddClaimRequest {

  @JsonKey(name: 'AddClaimRequest')
  final AddClaimRequest request;

  PsTpOAddClaimRequest(this.request);

  factory PsTpOAddClaimRequest.fromJson(Map<String, dynamic> json) => _$PsTpOAddClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOAddClaimRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class AddClaimRequest {
  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  @JsonKey(name: 'ServiceCode')
  final int serviceCode;

  @JsonKey(name: 'AccNum')
  final String accNum;

  @JsonKey(name: 'Sum')
  final double sum;

  @JsonKey(name: 'DueDate')
  final String dueDate;

  @JsonKey(name: 'FIO')
  final String? fio;

  @JsonKey(name: 'Address')
  final String? address;

  @JsonKey(name: 'ProductCharacter')
  final String? productCharacter;

  @JsonKey(name: 'Type_Notification')
  final int? typeNotification;

  AddClaimRequest({
    required this.version,
    required this.key,
    required this.token,
    required this.terminalId,
    required this.serviceCode,
    required this.accNum,
    required this.sum,
    required this.dueDate,
    this.fio,
    this.address,
    this.productCharacter,
    this.typeNotification,
  });


  factory AddClaimRequest.fromJson(Map<String, dynamic> json) => _$AddClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddClaimRequestToJson(this);

  AddClaimRequest copyWith({
    int? version,
    int? key,
    String? token,
    String? terminalId,
    int? serviceCode,
    String? accNum,
    double? sum,
    String? dueDate,
    String? fio,
    String? address,
    String? productCharacter,
    int? typeNotification,
  }) => AddClaimRequest(
      version: version ?? this.version,
      key: key ?? this.key,
      token: token ?? this.token,
      terminalId: terminalId ?? this.terminalId,
      serviceCode: serviceCode ?? this.serviceCode,
      accNum: accNum ?? this.accNum,
      sum: sum ?? this.sum,
      dueDate: dueDate ?? this.dueDate,
      fio: fio ?? this.fio,
      address: address ?? this.address,
      productCharacter: productCharacter ?? this.productCharacter,
      typeNotification: typeNotification ?? this.typeNotification,
    );
}

