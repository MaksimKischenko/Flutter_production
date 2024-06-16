// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_primary_secret_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayGetPrimarySecretKeyResponseWrapper
    _$PsHelppayGetPrimarySecretKeyResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayGetPrimarySecretKeyResponseWrapper(
          GetPrimarySecretKeyResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayGetPrimarySecretKeyResponseWrapperToJson(
        PsHelppayGetPrimarySecretKeyResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.response,
    };

GetPrimarySecretKeyResponse _$GetPrimarySecretKeyResponseFromJson(
        Map<String, dynamic> json) =>
    GetPrimarySecretKeyResponse(
      errorCode: json['ErrorCode'] as int,
      secretKey: json['Key'] as String,
      errorText: json['ErrorMessage'] as String?,
    );

Map<String, dynamic> _$GetPrimarySecretKeyResponseToJson(
    GetPrimarySecretKeyResponse instance) {
  final val = <String, dynamic>{
    'Key': instance.secretKey,
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorMessage', instance.errorText);
  return val;
}
