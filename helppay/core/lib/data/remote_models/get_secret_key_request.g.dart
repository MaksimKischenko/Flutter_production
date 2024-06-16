// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_secret_key_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayGetSecretKeyRequestWrapper
    _$PsHelppayGetSecretKeyRequestWrapperFromJson(Map<String, dynamic> json) =>
        PsHelppayGetSecretKeyRequestWrapper(
          PsHelppayGetSecretKeyRequest.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayGetSecretKeyRequestWrapperToJson(
        PsHelppayGetSecretKeyRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayGetSecretKeyRequest _$PsHelppayGetSecretKeyRequestFromJson(
        Map<String, dynamic> json) =>
    PsHelppayGetSecretKeyRequest(
      GetSecretKeyRequest.fromJson(
          json['GetSecretKeyRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayGetSecretKeyRequestToJson(
        PsHelppayGetSecretKeyRequest instance) =>
    <String, dynamic>{
      'GetSecretKeyRequest': instance.request,
    };

GetSecretKeyRequest _$GetSecretKeyRequestFromJson(Map<String, dynamic> json) =>
    GetSecretKeyRequest(
      terminalId: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String?,
      pan: json['PAN'] == null
          ? null
          : QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSecretKeyRequestToJson(GetSecretKeyRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalId,
    'Version': instance.version,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('TypePAN', instance.typePan);
  writeNotNull('PAN', instance.pan);
  return val;
}
