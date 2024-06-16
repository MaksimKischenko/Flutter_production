// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_basket_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripOpenBasketRequestWrapper _$PsEripOpenBasketRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripOpenBasketRequestWrapper(
      PsEripOpenBasketRequest.fromJson(json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripOpenBasketRequestWrapperToJson(
        PsEripOpenBasketRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripOpenBasketRequest _$PsEripOpenBasketRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripOpenBasketRequest(
      OpenBasketRequest.fromJson(
          json['OpenBasketRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripOpenBasketRequestToJson(
        PsEripOpenBasketRequest instance) =>
    <String, dynamic>{
      'OpenBasketRequest': instance.request,
    };

OpenBasketRequest _$OpenBasketRequestFromJson(Map<String, dynamic> json) =>
    OpenBasketRequest(
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      clientInfo: json['ClientInfo'] == null
          ? null
          : ClientInfo.fromJson(json['ClientInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenBasketRequestToJson(OpenBasketRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalId,
      'Version': instance.version,
      'ClientInfo': instance.clientInfo,
    };

ClientInfo _$ClientInfoFromJson(Map<String, dynamic> json) => ClientInfo(
      id: json['@ID'] as String?,
      idType: json['@IdType'] as String?,
      name: json['@Name'] as String?,
      unp: json['@UNP'] as String?,
    );

Map<String, dynamic> _$ClientInfoToJson(ClientInfo instance) =>
    <String, dynamic>{
      '@ID': instance.id,
      '@IdType': instance.idType,
      '@Name': instance.name,
      '@UNP': instance.unp,
    };
