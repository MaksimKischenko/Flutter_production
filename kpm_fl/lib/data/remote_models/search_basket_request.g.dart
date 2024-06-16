// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_basket_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripSearchBasketRequestWrapper _$PsEripSearchBasketRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripSearchBasketRequestWrapper(
      PsEripSearchBasketRequest.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripSearchBasketRequestWrapperToJson(
        PsEripSearchBasketRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripSearchBasketRequest _$PsEripSearchBasketRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripSearchBasketRequest(
      SearchBasketRequest.fromJson(
          json['SearchBasketRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripSearchBasketRequestToJson(
        PsEripSearchBasketRequest instance) =>
    <String, dynamic>{
      'SearchBasketRequest': instance.request,
    };

SearchBasketRequest _$SearchBasketRequestFromJson(Map<String, dynamic> json) =>
    SearchBasketRequest(
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      barcode: json['BarCode'] as String,
    );

Map<String, dynamic> _$SearchBasketRequestToJson(
        SearchBasketRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalId,
      'Version': instance.version,
      'BarCode': instance.barcode,
    };
