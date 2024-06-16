// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_secret_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayGetSecretKeyResponseWrapper
    _$PsHelppayGetSecretKeyResponseWrapperFromJson(Map<String, dynamic> json) =>
        PsHelppayGetSecretKeyResponseWrapper(
          PsHelppayGetSecretKeyResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayGetSecretKeyResponseWrapperToJson(
        PsHelppayGetSecretKeyResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayGetSecretKeyResponse _$PsHelppayGetSecretKeyResponseFromJson(
        Map<String, dynamic> json) =>
    PsHelppayGetSecretKeyResponse(
      GetSecretKeyResponse.fromJson(
          json['GetSecretKeyResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayGetSecretKeyResponseToJson(
        PsHelppayGetSecretKeyResponse instance) =>
    <String, dynamic>{
      'GetSecretKeyResponse': instance.response,
    };

GetSecretKeyResponse _$GetSecretKeyResponseFromJson(
        Map<String, dynamic> json) =>
    GetSecretKeyResponse(
      errorCode: json['ErrorCode'] as int,
      secretKey: SecretKey.fromJson(json['SecretKey'] as Map<String, dynamic>),
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$GetSecretKeyResponseToJson(
    GetSecretKeyResponse instance) {
  final val = <String, dynamic>{
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  val['SecretKey'] = instance.secretKey;
  return val;
}

SecretKey _$SecretKeyFromJson(Map<String, dynamic> json) => SecretKey(
      evalue: json['Value'] as String?,
      validity: json['Validity'] as int,
    );

Map<String, dynamic> _$SecretKeyToJson(SecretKey instance) => <String, dynamic>{
      'Value': instance.evalue,
      'Validity': instance.validity,
    };
