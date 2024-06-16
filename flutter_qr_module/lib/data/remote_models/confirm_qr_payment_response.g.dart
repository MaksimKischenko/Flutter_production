// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_qr_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayConfirmQrPaymentResponseWrapper
    _$PsHelppayConfirmQrPaymentResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayConfirmQrPaymentResponseWrapper(
          PsHelppayConfirmQrPaymentResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayConfirmQrPaymentResponseWrapperToJson(
        PsHelppayConfirmQrPaymentResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayConfirmQrPaymentResponse _$PsHelppayConfirmQrPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    PsHelppayConfirmQrPaymentResponse(
      ConfirmQrPaymentResponse.fromJson(
          json['ConfirmQRPaymentResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayConfirmQrPaymentResponseToJson(
        PsHelppayConfirmQrPaymentResponse instance) =>
    <String, dynamic>{
      'ConfirmQRPaymentResponse': instance.response,
    };

ConfirmQrPaymentResponse _$ConfirmQrPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmQrPaymentResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$ConfirmQrPaymentResponseToJson(
    ConfirmQrPaymentResponse instance) {
  final val = <String, dynamic>{
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  return val;
}
