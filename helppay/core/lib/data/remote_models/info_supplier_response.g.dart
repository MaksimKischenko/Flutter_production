// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_supplier_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomInfoSupplierResponseWrapper _$MdomInfoSupplierResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomInfoSupplierResponseWrapper(
      MdomInfoSupplierResponse.fromJson(
          json['TPInfoResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomInfoSupplierResponseWrapperToJson(
        MdomInfoSupplierResponseWrapper instance) =>
    <String, dynamic>{
      'TPInfoResponse': instance.response,
    };

MdomInfoSupplierResponse _$MdomInfoSupplierResponseFromJson(
        Map<String, dynamic> json) =>
    MdomInfoSupplierResponse(
      requestType: json['RequestType'] as String? ?? 'InfoSupplier',
      errorCode: json['ErrorCode'] == null
          ? null
          : MdomTpInfoErrorCode.fromJson(
              json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] as String,
      companies: (json['Company'] as List<dynamic>?)
          ?.map((e) =>
              InfoSupplierResponseCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomInfoSupplierResponseToJson(
        MdomInfoSupplierResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
      'Company': instance.companies,
    };

InfoSupplierResponseCompany _$InfoSupplierResponseCompanyFromJson(
        Map<String, dynamic> json) =>
    InfoSupplierResponseCompany(
      supplierId: json['SupplierId'] as int?,
      objectParam: json['Params'] == null
          ? null
          : MdomObjectParam.fromJson(json['Params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InfoSupplierResponseCompanyToJson(
        InfoSupplierResponseCompany instance) =>
    <String, dynamic>{
      'SupplierId': instance.supplierId,
      'Params': instance.objectParam,
    };
