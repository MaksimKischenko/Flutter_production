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
      serviceCode: json['ServiceCode'] as int,
      dateFrom: json['DateFrom'] as String,
      dateTo: json['DateTo'] as String,
      accNum: json['AccNum'] as String?,
      claimId: json['ClaimId'] as int?,
      status: json['Status'] as int?,
      rowCount: json['RowCount'] == null
          ? null
          : RowCountClaims.fromJson(json['RowCount'] as Map<String, dynamic>),
      token: json['Token'] as String,
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
    );

Map<String, dynamic> _$ClaimsListRequestToJson(ClaimsListRequest instance) {
  final val = <String, dynamic>{
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
  writeNotNull('Status', instance.status);
  writeNotNull('RowCount', instance.rowCount);
  val['Token'] = instance.token;
  val['Version'] = instance.version;
  val['KeyRequest'] = instance.key;
  return val;
}

RowCountClaims _$RowCountClaimsFromJson(Map<String, dynamic> json) =>
    RowCountClaims(
      evalue: json['evalue'] as int,
      claimId: json['@ClaimId'] as int?,
    );

Map<String, dynamic> _$RowCountClaimsToJson(RowCountClaims instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@ClaimId': instance.claimId,
    };
