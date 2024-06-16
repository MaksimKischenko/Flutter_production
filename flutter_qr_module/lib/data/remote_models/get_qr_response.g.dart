// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayGetQrResponseWrapper _$PsHelppayGetQrResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsHelppayGetQrResponseWrapper(
      PsHelppayGetQrResponse.fromJson(
          json['PS_HELPPAY'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayGetQrResponseWrapperToJson(
        PsHelppayGetQrResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayGetQrResponse _$PsHelppayGetQrResponseFromJson(
        Map<String, dynamic> json) =>
    PsHelppayGetQrResponse(
      GetQrResponse.fromJson(json['GetQRResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayGetQrResponseToJson(
        PsHelppayGetQrResponse instance) =>
    <String, dynamic>{
      'GetQRResponse': instance.response,
    };

GetQrResponse _$GetQrResponseFromJson(Map<String, dynamic> json) =>
    GetQrResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      agregatorSumLimit: (json['PaySumWithOTP'] as num?)?.toDouble(),
      qrCode: json['QRCode'] as Map<String, dynamic>?,
      qrCodeLifetime: json['QRValidity'] as int?,
    );

Map<String, dynamic> _$GetQrResponseToJson(GetQrResponse instance) {
  final val = <String, dynamic>{
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('QRCode', instance.qrCode);
  writeNotNull('PaySumWithOTP', instance.agregatorSumLimit);
  writeNotNull('QRValidity', instance.qrCodeLifetime);
  return val;
}
