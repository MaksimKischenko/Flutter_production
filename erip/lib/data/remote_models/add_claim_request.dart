// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/data/data.dart';
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

  @JsonKey(name: 'ServiceCode')
  final int serviceCode;

  @JsonKey(name: 'AccNum')
  final String? accNum;

  @JsonKey(name: 'Sum')
  final AddClaimRequestSum sum;

  //optional
  @JsonKey(name: 'Device')
  final Devices? device;

  @JsonKey(name: 'DueDate')
  final String dueDate;

  @JsonKey(name: 'FIO')
  final Fio? fio;

  @JsonKey(name: 'Address')
  final Address? address;

  @JsonKey(name: 'ProductCharacter')
  final String? productCharacter;

  //optional
  @JsonKey(name: 'Type_Notification')
  final int? typeNotification;

  //optional
  @JsonKey(name: 'Email')
  final String? email;

  //optional
  @JsonKey(name: 'SMS_Phone')
  final String? smsPhone;

  @JsonKey(name: 'Token')
  final String? token;

  @JsonKey(name: 'Version')
  final int? version;

  @JsonKey(name: 'KeyRequest')
  final int? key;

  AddClaimRequest({
    required this.serviceCode,
    this.accNum,
    required this.sum,
    this.device,
    required this.dueDate,
    this.fio,
    this.address,
    this.productCharacter,
    this.typeNotification,
    this.email,
    this.smsPhone,
    this.token,
    this.version,
    this.key
  });

  AddClaimRequest copy({
    int? serviceCode,
    String? accNum,
    AddClaimRequestSum? sum,
    Devices? device,
    String? dueDate,
    Fio? fio,
    Address? address,
    String? productCharacter,
    int? typeNotification,
    String? email,
    String? smsPhone,
    String? token,
    int? version,
    int? key,
  }) => AddClaimRequest(
    serviceCode: serviceCode ?? this.serviceCode,
    accNum: accNum ?? this.accNum,
    sum: sum ?? this.sum,
    device: device ?? this.device,
    dueDate: dueDate ?? this.dueDate,
    fio: fio ?? this.fio,
    address: address ?? this.address,
    productCharacter: productCharacter ?? this.productCharacter,
    typeNotification: typeNotification ?? this.typeNotification,
    email: email ?? this.email,
    smsPhone: smsPhone ?? this.smsPhone,
    token: token ?? this.token,
    version: version ?? this.version,
    key: key ?? this.key,
  );  

  factory AddClaimRequest.fromJson(Map<String, dynamic> json) => _$AddClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddClaimRequestToJson(this);

}

@JsonSerializable(includeIfNull: false)
class AddClaimRequestSum {

  @JsonKey(name: 'evalue')
  final double evalue;

  @JsonKey(name: '@Price')
  final double? price;

  @JsonKey(name: '@Quantity')
  final int? quantity;

  AddClaimRequestSum({
    required this.evalue,
    this.price,
    this.quantity,
  });

  factory AddClaimRequestSum.fromJson(Map<String, dynamic> json) => _$AddClaimRequestSumFromJson(json);

  Map<String, dynamic> toJson() => _$AddClaimRequestSumToJson(this);
  
}
