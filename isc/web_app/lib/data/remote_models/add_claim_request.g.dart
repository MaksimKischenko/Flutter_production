// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_claim_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOAddClaimRequestWrapper _$PsTpOAddClaimRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOAddClaimRequestWrapper(
      PsTpOAddClaimRequest.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAddClaimRequestWrapperToJson(
        PsTpOAddClaimRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOAddClaimRequest _$PsTpOAddClaimRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOAddClaimRequest(
      AddClaimRequest.fromJson(json['AddClaimRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAddClaimRequestToJson(
        PsTpOAddClaimRequest instance) =>
    <String, dynamic>{
      'AddClaimRequest': instance.request,
    };

AddClaimRequest _$AddClaimRequestFromJson(Map<String, dynamic> json) =>
    AddClaimRequest(
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      token: json['Token'] as String,
      terminalId: json['TerminalId'] as String,
      serviceCode: json['ServiceCode'] as int,
      accNum: json['AccNum'] as String,
      sum: (json['Sum'] as num).toDouble(),
      dueDate: json['DueDate'] as String,
      fio: json['FIO'] as String?,
      address: json['Address'] as String?,
      productCharacter: json['ProductCharacter'] as String?,
      typeNotification: json['Type_Notification'] as int?,
    );

Map<String, dynamic> _$AddClaimRequestToJson(AddClaimRequest instance) {
  final val = <String, dynamic>{
    'Version': instance.version,
    'KeyRequest': instance.key,
    'Token': instance.token,
    'TerminalId': instance.terminalId,
    'ServiceCode': instance.serviceCode,
    'AccNum': instance.accNum,
    'Sum': instance.sum,
    'DueDate': instance.dueDate,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FIO', instance.fio);
  writeNotNull('Address', instance.address);
  writeNotNull('ProductCharacter', instance.productCharacter);
  writeNotNull('Type_Notification', instance.typeNotification);
  return val;
}
