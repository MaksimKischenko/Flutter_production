// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOSupplierStatusRequestWrapper _$PsTpOSupplierStatusRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOSupplierStatusRequestWrapper(
      PsTpOSupplierStatusRequest.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOSupplierStatusRequestWrapperToJson(
        PsTpOSupplierStatusRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOSupplierStatusRequest _$PsTpOSupplierStatusRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOSupplierStatusRequest(
      SupplierStatusRequest.fromJson(
          json['SupplierStatusRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOSupplierStatusRequestToJson(
        PsTpOSupplierStatusRequest instance) =>
    <String, dynamic>{
      'SupplierStatusRequest': instance.request,
    };

SupplierStatusRequest _$SupplierStatusRequestFromJson(
        Map<String, dynamic> json) =>
    SupplierStatusRequest(
      version: json['Version'] as int,
      token: json['Token'] as String,
      key: json['KeyRequest'] as int,
    );

Map<String, dynamic> _$SupplierStatusRequestToJson(
        SupplierStatusRequest instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'Token': instance.token,
      'KeyRequest': instance.key,
    };
