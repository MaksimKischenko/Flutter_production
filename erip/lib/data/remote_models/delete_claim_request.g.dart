// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_claim_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpODeleteClaimRequestWrapper _$PsTpODeleteClaimRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteClaimRequestWrapper(
      PsTpODeleteClaimRequest.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteClaimRequestWrapperToJson(
        PsTpODeleteClaimRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpODeleteClaimRequest _$PsTpODeleteClaimRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteClaimRequest(
      DeleteClaimRequest.fromJson(
          json['DeleteClaimRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteClaimRequestToJson(
        PsTpODeleteClaimRequest instance) =>
    <String, dynamic>{
      'DeleteClaimRequest': instance.request,
    };

DeleteClaimRequest _$DeleteClaimRequestFromJson(Map<String, dynamic> json) =>
    DeleteClaimRequest(
      claimId: json['ClaimId'] as int,
      token: json['Token'] as String,
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
    );

Map<String, dynamic> _$DeleteClaimRequestToJson(DeleteClaimRequest instance) =>
    <String, dynamic>{
      'ClaimId': instance.claimId,
      'Token': instance.token,
      'Version': instance.version,
      'KeyRequest': instance.key,
    };
