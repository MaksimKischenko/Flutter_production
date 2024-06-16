// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOClaimsListRequestWrapper _$PsTpOClaimsListRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOClaimsListRequestWrapper(
      PsTpOClaimsListRequest.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOClaimsListRequestWrapperToJson(
        PsTpOClaimsListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOClaimsListRequest _$PsTpOClaimsListRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOClaimsListRequest(
      ClaimsListRequest.fromJson(
          json['ClaimsListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOClaimsListRequestToJson(
        PsTpOClaimsListRequest instance) =>
    <String, dynamic>{
      'ClaimsListRequest': instance.request,
    };

ClaimsListRequest _$ClaimsListRequestFromJson(Map<String, dynamic> json) =>
    ClaimsListRequest(
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      token: json['Token'] as String,
      terminalId: json['TerminalId'] as String,
      serviceCode: json['ServiceCode'] as int,
      dateFrom: json['DateFrom'] as String,
      dateTo: json['DateTo'] as String,
      accNum: json['AccNum'] as String?,
      claimId: json['ClaimId'] as int?,
      status: $enumDecodeNullable(_$ClaimStatusEnumMap, json['Status']),
      rowCount: json['RowCount'] == null
          ? null
          : RowCountClaims.fromJson(json['RowCount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimsListRequestToJson(ClaimsListRequest instance) {
  final val = <String, dynamic>{
    'Version': instance.version,
    'KeyRequest': instance.key,
    'Token': instance.token,
    'TerminalId': instance.terminalId,
    'ServiceCode': instance.serviceCode,
    'DateFrom': instance.dateFrom,
    'DateTo': instance.dateTo,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AccNum', instance.accNum);
  writeNotNull('ClaimId', instance.claimId);
  writeNotNull('Status', _$ClaimStatusEnumMap[instance.status]);
  writeNotNull('RowCount', instance.rowCount);
  return val;
}

const _$ClaimStatusEnumMap = {
  ClaimStatus.all: 0,
  ClaimStatus.unpaid: 1,
  ClaimStatus.fullyPaid: 2,
  ClaimStatus.partiallyPaid: 3,
  ClaimStatus.overdue: 4,
};

RowCountClaims _$RowCountClaimsFromJson(Map<String, dynamic> json) =>
    RowCountClaims(
      evalue: json['evalue'] as int,
      claimId: json['@ClaimId'] as int?,
    );

Map<String, dynamic> _$RowCountClaimsToJson(RowCountClaims instance) {
  final val = <String, dynamic>{
    'evalue': instance.evalue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@ClaimId', instance.claimId);
  return val;
}
