// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_basket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripCloseBasketResponseWrapper _$PsEripCloseBasketResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripCloseBasketResponseWrapper(
      PsEripCloseBasketResponse.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripCloseBasketResponseWrapperToJson(
        PsEripCloseBasketResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripCloseBasketResponse _$PsEripCloseBasketResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripCloseBasketResponse(
      CloseBasketResponse.fromJson(
          json['CloseBasketResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripCloseBasketResponseToJson(
        PsEripCloseBasketResponse instance) =>
    <String, dynamic>{
      'CloseBasketResponse': instance.response,
    };

CloseBasketResponse _$CloseBasketResponseFromJson(Map<String, dynamic> json) =>
    CloseBasketResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      printerExists: json['PrinterExists'] as int?,
      check: json['Check'] == null
          ? null
          : CheckResponse.fromJson(json['Check'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CloseBasketResponseToJson(
        CloseBasketResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'PrinterExists': instance.printerExists,
      'Check': instance.check,
    };
