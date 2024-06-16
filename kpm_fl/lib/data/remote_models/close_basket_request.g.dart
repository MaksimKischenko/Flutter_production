// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_basket_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripCloseBasketRequestWrapper _$PsEripCloseBasketRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripCloseBasketRequestWrapper(
      PsEripCloseBasketRequest.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripCloseBasketRequestWrapperToJson(
        PsEripCloseBasketRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripCloseBasketRequest _$PsEripCloseBasketRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripCloseBasketRequest(
      CloseBasketRequest.fromJson(
          json['CloseBasketRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripCloseBasketRequestToJson(
        PsEripCloseBasketRequest instance) =>
    <String, dynamic>{
      'CloseBasketRequest': instance.request,
    };

CloseBasketRequest _$CloseBasketRequestFromJson(Map<String, dynamic> json) =>
    CloseBasketRequest(
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      barcode: json['BarCode'] as String?,
    );

Map<String, dynamic> _$CloseBasketRequestToJson(CloseBasketRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalId,
      'Version': instance.version,
      'BarCode': instance.barcode,
    };
