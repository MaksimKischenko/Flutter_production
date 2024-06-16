// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_balance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripGetBalanceRequestWrapper _$PsEripGetBalanceRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripGetBalanceRequestWrapper(
      PsEripGetBalanceRequest.fromJson(json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetBalanceRequestWrapperToJson(
        PsEripGetBalanceRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.request,
    };

PsEripGetBalanceRequest _$PsEripGetBalanceRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripGetBalanceRequest(
      GetBalanceRequest.fromJson(
          json['GetBalanceRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetBalanceRequestToJson(
        PsEripGetBalanceRequest instance) =>
    <String, dynamic>{
      'GetBalanceRequest': instance.request,
    };

GetBalanceRequest _$GetBalanceRequestFromJson(Map<String, dynamic> json) =>
    GetBalanceRequest(
      terminalID: json['TerminalID'] as String,
      version: json['Version'] as int,
      diType: json['DIType'] as int,
      typePan: json['TypePAN'] == null
          ? null
          : TypePan.fromJson(json['TypePAN'] as Map<String, dynamic>),
      pan: json['PAN'] == null
          ? null
          : Pan.fromJson(json['PAN'] as Map<String, dynamic>),
      token: json['Token'] as String,
      currency: json['Currency'] as int,
      requestType: json['RequestType'] as int,
    );

Map<String, dynamic> _$GetBalanceRequestToJson(GetBalanceRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'Version': instance.version,
    'DIType': instance.diType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PAN', instance.pan);
  writeNotNull('TypePAN', instance.typePan);
  val['Token'] = instance.token;
  val['Currency'] = instance.currency;
  val['RequestType'] = instance.requestType;
  return val;
}
