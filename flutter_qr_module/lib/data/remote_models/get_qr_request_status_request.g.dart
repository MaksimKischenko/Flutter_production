// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_request_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelpPayQRRequestStatusRequestWrapper
    _$PsHelpPayQRRequestStatusRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelpPayQRRequestStatusRequestWrapper(
          PsHelpPayQRRequestStatusRequest.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelpPayQRRequestStatusRequestWrapperToJson(
        PsHelpPayQRRequestStatusRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelpPayQRRequestStatusRequest _$PsHelpPayQRRequestStatusRequestFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQRRequestStatusRequest(
      QRRequestStatusRequest.fromJson(
          json['GetReqIdStatusRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQRRequestStatusRequestToJson(
        PsHelpPayQRRequestStatusRequest instance) =>
    <String, dynamic>{
      'GetReqIdStatusRequest': instance.request,
    };

QRRequestStatusRequest _$QRRequestStatusRequestFromJson(
        Map<String, dynamic> json) =>
    QRRequestStatusRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      requestId: json['RequestId'] as int,
    );

Map<String, dynamic> _$QRRequestStatusRequestToJson(
        QRRequestStatusRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalID,
      'Version': instance.version,
      'TypePAN': instance.typePan,
      'PAN': instance.pan,
      'RequestId': instance.requestId,
    };
