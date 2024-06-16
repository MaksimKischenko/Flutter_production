// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOSupplierStatusResponseWrapper _$PsTpOSupplierStatusResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOSupplierStatusResponseWrapper(
      PsTpOSupplierStatusResponse.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOSupplierStatusResponseWrapperToJson(
        PsTpOSupplierStatusResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOSupplierStatusResponse _$PsTpOSupplierStatusResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOSupplierStatusResponse(
      SupplierStatusResponse.fromJson(
          json['SupplierStatusResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOSupplierStatusResponseToJson(
        PsTpOSupplierStatusResponse instance) =>
    <String, dynamic>{
      'SupplierStatusResponse': instance.response,
    };

SupplierStatusResponse _$SupplierStatusResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierStatusResponse(
      eripStatus: json['EripStatus'] as int,
      testModeStatus: json['TestModeStatus'] as int,
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$SupplierStatusResponseToJson(
        SupplierStatusResponse instance) =>
    <String, dynamic>{
      'EripStatus': instance.eripStatus,
      'TestModeStatus': instance.testModeStatus,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
