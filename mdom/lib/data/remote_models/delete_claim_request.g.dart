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
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      token: json['Token'] as String,
      terminalId: json['TerminalId'] as String,
      claimId: json['ClaimId'] as int,
    );

Map<String, dynamic> _$DeleteClaimRequestToJson(DeleteClaimRequest instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.key,
      'Token': instance.token,
      'TerminalId': instance.terminalId,
      'ClaimId': instance.claimId,
    };
