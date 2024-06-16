// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_operations_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelpPayQROperationRequestWrapper _$PsHelpPayQROperationRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQROperationRequestWrapper(
      PsHelpPayQROperationRequest.fromJson(
          json['PS_HELPPAY'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQROperationRequestWrapperToJson(
        PsHelpPayQROperationRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelpPayQROperationRequest _$PsHelpPayQROperationRequestFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQROperationRequest(
      GetQROperationRequest.fromJson(
          json['GetQROperationRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQROperationRequestToJson(
        PsHelpPayQROperationRequest instance) =>
    <String, dynamic>{
      'GetQROperationRequest': instance.request,
    };

GetQROperationRequest _$GetQROperationRequestFromJson(
        Map<String, dynamic> json) =>
    GetQROperationRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      filter: OperationFilter.fromJson(json['Filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetQROperationRequestToJson(
        GetQROperationRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalID,
      'Version': instance.version,
      'TypePAN': instance.typePan,
      'PAN': instance.pan,
      'Filter': instance.filter,
    };

OperationFilter _$OperationFilterFromJson(Map<String, dynamic> json) =>
    OperationFilter(
      dateFrom: json['DateFrom'] as String,
      dateTo: json['DateTo'] as String,
    );

Map<String, dynamic> _$OperationFilterToJson(OperationFilter instance) =>
    <String, dynamic>{
      'DateFrom': instance.dateFrom,
      'DateTo': instance.dateTo,
    };
