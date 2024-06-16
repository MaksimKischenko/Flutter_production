// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_operation_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripGetOperationHistoryRequestWrapper
    _$PsEripGetOperationHistoryRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsEripGetOperationHistoryRequestWrapper(
          PsEripGetOperationHistoryRequest.fromJson(
              json['PS_ERIP'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsEripGetOperationHistoryRequestWrapperToJson(
        PsEripGetOperationHistoryRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripGetOperationHistoryRequest _$PsEripGetOperationHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripGetOperationHistoryRequest(
      GetOperationHistoryRequest.fromJson(
          json['GetOperationHistoryRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetOperationHistoryRequestToJson(
        PsEripGetOperationHistoryRequest instance) =>
    <String, dynamic>{
      'GetOperationHistoryRequest': instance.request,
    };

GetOperationHistoryRequest _$GetOperationHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    GetOperationHistoryRequest(
      terminalID: json['TerminalID'] as String,
      version: json['Version'] as int,
      token: json['Token'] as String,
      sourceId: GetOperationHistoryRequestSourceId.fromJson(
          json['SourceId'] as Map<String, dynamic>),
      requestTerminalID: json['RequestTerminalID'] as String?,
      filter: json['Filter'] == null
          ? null
          : GetOperationHistoryRequestFilter.fromJson(
              json['Filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOperationHistoryRequestToJson(
    GetOperationHistoryRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'Version': instance.version,
    'Token': instance.token,
    'SourceId': instance.sourceId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('RequestTerminalID', instance.requestTerminalID);
  writeNotNull('Filter', instance.filter);
  return val;
}

GetOperationHistoryRequestSourceId _$GetOperationHistoryRequestSourceIdFromJson(
        Map<String, dynamic> json) =>
    GetOperationHistoryRequestSourceId(
      evalue: json['evalue'] as String,
      type: json['@Type'] as String,
    );

Map<String, dynamic> _$GetOperationHistoryRequestSourceIdToJson(
        GetOperationHistoryRequestSourceId instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Type': instance.type,
    };

GetOperationHistoryRequestFilter _$GetOperationHistoryRequestFilterFromJson(
        Map<String, dynamic> json) =>
    GetOperationHistoryRequestFilter(
      dateFrom: json['@DateFrom'] as String,
      dateTo: json['@DateTo'] as String,
      amount: (json['@Amount'] as num?)?.toDouble(),
      payName: json['@PayName'] as String?,
      listSize: json['@ListSize'] as int?,
      lastPaymentId: json['@LastPaymentId'] as int?,
      payCode: json['@PayCode'] as int?,
      ls: json['@LS'] as String?,
      payCurrency: json['@PayCurrency'] as int?,
    );

Map<String, dynamic> _$GetOperationHistoryRequestFilterToJson(
    GetOperationHistoryRequestFilter instance) {
  final val = <String, dynamic>{
    '@DateFrom': instance.dateFrom,
    '@DateTo': instance.dateTo,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@Amount', instance.amount);
  writeNotNull('@PayName', instance.payName);
  writeNotNull('@ListSize', instance.listSize);
  writeNotNull('@LastPaymentId', instance.lastPaymentId);
  writeNotNull('@PayCode', instance.payCode);
  writeNotNull('@LS', instance.ls);
  writeNotNull('@PayCurrency', instance.payCurrency);
  return val;
}
