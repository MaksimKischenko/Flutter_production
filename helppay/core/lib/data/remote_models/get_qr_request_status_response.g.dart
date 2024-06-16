// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_request_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelpPayQRRequestStatusWrapper _$PsHelpPayQRRequestStatusWrapperFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQRRequestStatusWrapper(
      PsHelpPayQRRequestStatusResponse.fromJson(
          json['PS_HELPPAY'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQRRequestStatusWrapperToJson(
        PsHelpPayQRRequestStatusWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelpPayQRRequestStatusResponse _$PsHelpPayQRRequestStatusResponseFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQRRequestStatusResponse(
      QRRequestStatusResponse.fromJson(
          json['GetReqIdStatusResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQRRequestStatusResponseToJson(
        PsHelpPayQRRequestStatusResponse instance) =>
    <String, dynamic>{
      'GetReqIdStatusResponse': instance.response,
    };

QRRequestStatusResponse _$QRRequestStatusResponseFromJson(
        Map<String, dynamic> json) =>
    QRRequestStatusResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      finalPaymentSum: (json['RequestPaySum'] as num?)?.toDouble(),
      status: json['Status'] as int,
      statusDescription: json['StatusDescription'] as String?,
    );

Map<String, dynamic> _$QRRequestStatusResponseToJson(
        QRRequestStatusResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'Status': instance.status,
      'RequestPaySum': instance.finalPaymentSum,
      'StatusDescription': instance.statusDescription,
    };
