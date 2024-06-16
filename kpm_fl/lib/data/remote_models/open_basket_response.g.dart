// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_basket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripOpenBasketResponseWrapper _$PsEripOpenBasketResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripOpenBasketResponseWrapper(
      PsEripOpenBasketResponse.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripOpenBasketResponseWrapperToJson(
        PsEripOpenBasketResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripOpenBasketResponse _$PsEripOpenBasketResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripOpenBasketResponse(
      OpenBasketResponse.fromJson(
          json['OpenBasketResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripOpenBasketResponseToJson(
        PsEripOpenBasketResponse instance) =>
    <String, dynamic>{
      'OpenBasketResponse': instance.response,
    };

OpenBasketResponse _$OpenBasketResponseFromJson(Map<String, dynamic> json) =>
    OpenBasketResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      barcode: json['BarCode'] as String?,
      kioskReceipt: json['KioskReceipt'] as String?,
    );

Map<String, dynamic> _$OpenBasketResponseToJson(OpenBasketResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'BarCode': instance.barcode,
      'KioskReceipt': instance.kioskReceipt,
    };
