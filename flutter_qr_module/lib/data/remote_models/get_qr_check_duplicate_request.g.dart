// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_check_duplicate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelpPayQRCheckDuplicateRequestWrapper
    _$PsHelpPayQRCheckDuplicateRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelpPayQRCheckDuplicateRequestWrapper(
          PsHelpPayQRCheckDuplicateRequest.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelpPayQRCheckDuplicateRequestWrapperToJson(
        PsHelpPayQRCheckDuplicateRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelpPayQRCheckDuplicateRequest _$PsHelpPayQRCheckDuplicateRequestFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQRCheckDuplicateRequest(
      QRCheckDuplicateRequest.fromJson(
          json['GetQRCheckDuplicateRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQRCheckDuplicateRequestToJson(
        PsHelpPayQRCheckDuplicateRequest instance) =>
    <String, dynamic>{
      'GetQRCheckDuplicateRequest': instance.request,
    };

QRCheckDuplicateRequest _$QRCheckDuplicateRequestFromJson(
        Map<String, dynamic> json) =>
    QRCheckDuplicateRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      requestId: json['RequestId'] as int,
      advancedInfoRequired: json['Advanced'] as int?,
    );

Map<String, dynamic> _$QRCheckDuplicateRequestToJson(
    QRCheckDuplicateRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'Version': instance.version,
    'TypePAN': instance.typePan,
    'PAN': instance.pan,
    'RequestId': instance.requestId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Advanced', instance.advancedInfoRequired);
  return val;
}
