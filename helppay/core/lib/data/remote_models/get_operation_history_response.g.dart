// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_operation_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripGetOperationHistoryResponseWrapper
    _$PsEripGetOperationHistoryResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsEripGetOperationHistoryResponseWrapper(
          PsEripGetOperationHistoryResponse.fromJson(
              json['PS_ERIP'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsEripGetOperationHistoryResponseWrapperToJson(
        PsEripGetOperationHistoryResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripGetOperationHistoryResponse _$PsEripGetOperationHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripGetOperationHistoryResponse(
      GetOperationHistoryResponse.fromJson(
          json['GetOperationHistoryResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetOperationHistoryResponseToJson(
        PsEripGetOperationHistoryResponse instance) =>
    <String, dynamic>{
      'GetOperationHistoryResponse': instance.response,
    };

GetOperationHistoryResponse _$GetOperationHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetOperationHistoryResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      token: json['Token'] as String?,
      paymentList: json['PaymentList'] == null
          ? null
          : PaymentList.fromJson(json['PaymentList'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOperationHistoryResponseToJson(
    GetOperationHistoryResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('Token', instance.token);
  writeNotNull('PaymentList', instance.paymentList);
  return val;
}

PaymentList _$PaymentListFromJson(Map<String, dynamic> json) => PaymentList(
      count: json['@Count'] as int,
      requestTerminalID: json['@RequestTerminalID'] as String?,
      payments: (json['Payment'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentListToJson(PaymentList instance) =>
    <String, dynamic>{
      '@Count': instance.count,
      '@RequestTerminalID': instance.requestTerminalID,
      'Payment': instance.payments,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      paymentId: json['PaymentId'] as int,
      dateTime: json['DateTime'] as String,
      resultDescription: ResultDescription.fromJson(
          json['ResultDescription'] as Map<String, dynamic>),
      terminalID: PaymentTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      payName: json['PayName'] as String,
      ls: json['LS'] as String,
      amount: PaymentAmount.fromJson(json['Amount'] as Map<String, dynamic>),
      commissionAmount: PaymentCommissionAmount.fromJson(
          json['CommissionAmount'] as Map<String, dynamic>),
      authInfo: json['AuthInfo'] == null
          ? null
          : AuthInfo.fromJson(json['AuthInfo'] as Map<String, dynamic>),
      autoPayID: json['AutoPayID'] as int?,
      attrRecords: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => PaymentAttrRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'PaymentId': instance.paymentId,
      'DateTime': instance.dateTime,
      'ResultDescription': instance.resultDescription,
      'TerminalID': instance.terminalID,
      'PayName': instance.payName,
      'LS': instance.ls,
      'Amount': instance.amount,
      'CommissionAmount': instance.commissionAmount,
      'AuthInfo': instance.authInfo,
      'AutoPayID': instance.autoPayID,
      'AttrRecord': instance.attrRecords,
    };

ResultDescription _$ResultDescriptionFromJson(Map<String, dynamic> json) =>
    ResultDescription(
      evalue: json['evalue'] as String,
      code: json['@Code'] as int,
    );

Map<String, dynamic> _$ResultDescriptionToJson(ResultDescription instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Code': instance.code,
    };

PaymentTerminalID _$PaymentTerminalIDFromJson(Map<String, dynamic> json) =>
    PaymentTerminalID(
      evalue: json['evalue'] as String,
      type: json['@Type'] as String,
    );

Map<String, dynamic> _$PaymentTerminalIDToJson(PaymentTerminalID instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Type': instance.type,
    };

PaymentAmount _$PaymentAmountFromJson(Map<String, dynamic> json) =>
    PaymentAmount(
      evalue: (json['evalue'] as num).toDouble(),
      currency: json['@Currency'] as int,
    );

Map<String, dynamic> _$PaymentAmountToJson(PaymentAmount instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Currency': instance.currency,
    };

PaymentCommissionAmount _$PaymentCommissionAmountFromJson(
        Map<String, dynamic> json) =>
    PaymentCommissionAmount(
      evalue: (json['evalue'] as num).toDouble(),
      currency: json['@Currency'] as int,
    );

Map<String, dynamic> _$PaymentCommissionAmountToJson(
        PaymentCommissionAmount instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Currency': instance.currency,
    };

AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) => AuthInfo(
      rrn: json['@RRN'] as String,
      code: json['@Code'] as String,
    );

Map<String, dynamic> _$AuthInfoToJson(AuthInfo instance) => <String, dynamic>{
      '@RRN': instance.rrn,
      '@Code': instance.code,
    };

PaymentAttrRecord _$PaymentAttrRecordFromJson(Map<String, dynamic> json) =>
    PaymentAttrRecord(
      code: json['@Code'] as int,
      name: json['@Name'] as String,
      value: json['@Value'] as String?,
    );

Map<String, dynamic> _$PaymentAttrRecordToJson(PaymentAttrRecord instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@Name': instance.name,
      '@Value': instance.value,
    };
