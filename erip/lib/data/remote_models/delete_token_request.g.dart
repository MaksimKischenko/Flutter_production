// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpODeleteTokenRequestWrapper _$PsTpODeleteTokenRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteTokenRequestWrapper(
      PsTpODeleteTokenRequest.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteTokenRequestWrapperToJson(
        PsTpODeleteTokenRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpODeleteTokenRequest _$PsTpODeleteTokenRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteTokenRequest(
      DeleteTokenRequest.fromJson(
          json['DeleteTokenRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteTokenRequestToJson(
        PsTpODeleteTokenRequest instance) =>
    <String, dynamic>{
      'DeleteTokenRequest': instance.request,
    };

DeleteTokenRequest _$DeleteTokenRequestFromJson(Map<String, dynamic> json) =>
    DeleteTokenRequest(
      json['Token'] as String,
    );

Map<String, dynamic> _$DeleteTokenRequestToJson(DeleteTokenRequest instance) =>
    <String, dynamic>{
      'Token': instance.token,
    };
