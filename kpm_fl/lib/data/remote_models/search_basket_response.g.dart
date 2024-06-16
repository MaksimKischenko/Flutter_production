// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_basket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripSearchBasketResponseWrapper _$PsEripSearchBasketResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripSearchBasketResponseWrapper(
      PsEripSearchBasketResponse.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripSearchBasketResponseWrapperToJson(
        PsEripSearchBasketResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripSearchBasketResponse _$PsEripSearchBasketResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripSearchBasketResponse(
      SearchBasketResponse.fromJson(
          json['SearchBasketResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripSearchBasketResponseToJson(
        PsEripSearchBasketResponse instance) =>
    <String, dynamic>{
      'SearchBasketResponse': instance.response,
    };

SearchBasketResponse _$SearchBasketResponseFromJson(
        Map<String, dynamic> json) =>
    SearchBasketResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      barcode: json['BarCode'] as String?,
      status: $enumDecodeNullable(_$BasketStatusEnumMap, json['Status']),
      check: json['Check'] == null
          ? null
          : CheckResponse.fromJson(json['Check'] as Map<String, dynamic>),
      payCodeRecord: json['PayCodeRecord'] == null
          ? null
          : PayCodeRecordResponse.fromJson(
              json['PayCodeRecord'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchBasketResponseToJson(
        SearchBasketResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'BarCode': instance.barcode,
      'Status': _$BasketStatusEnumMap[instance.status],
      'Check': instance.check,
      'PayCodeRecord': instance.payCodeRecord,
    };

const _$BasketStatusEnumMap = {
  BasketStatus.opened: 1,
  BasketStatus.closed: 2,
  BasketStatus.paid: 3,
};

PayCodeRecordResponse _$PayCodeRecordResponseFromJson(
        Map<String, dynamic> json) =>
    PayCodeRecordResponse(
      payRecord: (json['PayRecord'] as List<dynamic>?)
          ?.map((e) => PayRecordResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayCodeRecordResponseToJson(
        PayCodeRecordResponse instance) =>
    <String, dynamic>{
      'PayRecord': instance.payRecord,
    };
