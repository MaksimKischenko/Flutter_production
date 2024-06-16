import 'package:json_annotation/json_annotation.dart';

part 'get_operation_history_response.g.dart';

@JsonSerializable()
class PsEripGetOperationHistoryResponseWrapper {
  @JsonKey(name: 'PS_ERIP')
  final PsEripGetOperationHistoryResponse psErip;

  PsEripGetOperationHistoryResponseWrapper(this.psErip);

  factory PsEripGetOperationHistoryResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsEripGetOperationHistoryResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsEripGetOperationHistoryResponseWrapperToJson(this);
}

@JsonSerializable()
class PsEripGetOperationHistoryResponse {
  @JsonKey(name: 'GetOperationHistoryResponse')
  final GetOperationHistoryResponse response;

  PsEripGetOperationHistoryResponse(this.response);

  factory PsEripGetOperationHistoryResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PsEripGetOperationHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsEripGetOperationHistoryResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GetOperationHistoryResponse {
  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Token')
  final String? token;

  @JsonKey(name: 'PaymentList')
  final PaymentList? paymentList;

  GetOperationHistoryResponse(
      {this.errorCode, this.errorText, this.token, this.paymentList});

  factory GetOperationHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOperationHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOperationHistoryResponseToJson(this);
}

@JsonSerializable()
class PaymentList {
  @JsonKey(name: '@Count')
  final int count;

  @JsonKey(name: '@RequestTerminalID')
  final String? requestTerminalID;

  @JsonKey(name: 'Payment')
  final List<Payment>? payments;

  PaymentList({required this.count, this.requestTerminalID, this.payments});

  factory PaymentList.fromJson(Map<String, dynamic> json) =>
      _$PaymentListFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentListToJson(this);
}

@JsonSerializable()
class Payment {
  @JsonKey(name: 'PaymentId')
  final int paymentId;

  @JsonKey(name: 'DateTime')
  final String dateTime;

  @JsonKey(name: 'ResultDescription')
  final ResultDescription resultDescription;

  @JsonKey(name: 'TerminalID')
  final PaymentTerminalID terminalID;

  @JsonKey(name: 'PayName')
  final String payName;

  @JsonKey(name: 'LS')
  final String ls;

  @JsonKey(name: 'Amount')
  final PaymentAmount amount;

  @JsonKey(name: 'CommissionAmount')
  final PaymentCommissionAmount commissionAmount;

  @JsonKey(name: 'AuthInfo')
  final AuthInfo? authInfo;

  @JsonKey(name: 'AutoPayID')
  final int? autoPayID;

  @JsonKey(name: 'AttrRecord')
  final List<PaymentAttrRecord>? attrRecords;

  Payment(
      {required this.paymentId,
      required this.dateTime,
      required this.resultDescription,
      required this.terminalID,
      required this.payName,
      required this.ls,
      required this.amount,
      required this.commissionAmount,
      this.authInfo,
      this.autoPayID,
      this.attrRecords});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable()
class ResultDescription {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Code')
  final int code;

  ResultDescription({required this.evalue, required this.code});

  factory ResultDescription.fromJson(Map<String, dynamic> json) =>
      _$ResultDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ResultDescriptionToJson(this);
}

@JsonSerializable()
class PaymentTerminalID {
  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Type')
  final String type;

  PaymentTerminalID({required this.evalue, required this.type});

  factory PaymentTerminalID.fromJson(Map<String, dynamic> json) =>
      _$PaymentTerminalIDFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTerminalIDToJson(this);
}

@JsonSerializable()
class PaymentAmount {
  @JsonKey(name: 'evalue')
  final double evalue;

  @JsonKey(name: '@Currency')
  final int currency;

  PaymentAmount({required this.evalue, required this.currency});

  factory PaymentAmount.fromJson(Map<String, dynamic> json) =>
      _$PaymentAmountFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentAmountToJson(this);
}

@JsonSerializable()
class PaymentCommissionAmount {
  @JsonKey(name: 'evalue')
  final double evalue;

  @JsonKey(name: '@Currency')
  final int currency;

  PaymentCommissionAmount({required this.evalue, required this.currency});

  factory PaymentCommissionAmount.fromJson(Map<String, dynamic> json) =>
      _$PaymentCommissionAmountFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCommissionAmountToJson(this);
}

@JsonSerializable()
class AuthInfo {
  @JsonKey(name: '@RRN')
  final String rrn;

  @JsonKey(name: '@Code')
  final String code;

  AuthInfo({required this.rrn, required this.code});

  factory AuthInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthInfoToJson(this);
}

@JsonSerializable()
class PaymentAttrRecord {
  @JsonKey(name: '@Code')
  final int code;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Value')
  final String? value;

  PaymentAttrRecord({required this.code, required this.name, this.value});

  factory PaymentAttrRecord.fromJson(Map<String, dynamic> json) =>
      _$PaymentAttrRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentAttrRecordToJson(this);
}
