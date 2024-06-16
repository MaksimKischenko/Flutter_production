// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_qr_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayConfirmQrPaymentRequestWrapper
    _$PsHelppayConfirmQrPaymentRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayConfirmQrPaymentRequestWrapper(
          PsHelppayConfirmQrPaymentRequest.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayConfirmQrPaymentRequestWrapperToJson(
        PsHelppayConfirmQrPaymentRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayConfirmQrPaymentRequest _$PsHelppayConfirmQrPaymentRequestFromJson(
        Map<String, dynamic> json) =>
    PsHelppayConfirmQrPaymentRequest(
      ConfirmQrPaymentRequest.fromJson(
          json['ConfirmQRPaymentRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayConfirmQrPaymentRequestToJson(
        PsHelppayConfirmQrPaymentRequest instance) =>
    <String, dynamic>{
      'ConfirmQRPaymentRequest': instance.request,
    };

ConfirmQrPaymentRequest _$ConfirmQrPaymentRequestFromJson(
        Map<String, dynamic> json) =>
    ConfirmQrPaymentRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      requestId:
          QrRequestId.fromJson(json['RequestId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmQrPaymentRequestToJson(
        ConfirmQrPaymentRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalID,
      'Version': instance.version,
      'TypePAN': instance.typePan,
      'PAN': instance.pan,
      'RequestId': instance.requestId,
    };

QrRequestId _$QrRequestIdFromJson(Map<String, dynamic> json) => QrRequestId(
      evalue: json['Value'] as int,
      otpCode: json['OTPCode'] as int?,
      confirmCode: json['ConfirmCode'] as int,
    );

Map<String, dynamic> _$QrRequestIdToJson(QrRequestId instance) =>
    <String, dynamic>{
      'Value': instance.evalue,
      'OTPCode': instance.otpCode,
      'ConfirmCode': instance.confirmCode,
    };
