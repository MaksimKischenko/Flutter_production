// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'get_qr_operations_response.g.dart';

@JsonSerializable()
class PsHelpPayQROperationResponseWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelpPayQROperationResponse psErip;

  PsHelpPayQROperationResponseWrapper(this.psErip);

  factory PsHelpPayQROperationResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayQROperationResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQROperationResponseWrapperToJson(this);
}

@JsonSerializable()
class PsHelpPayQROperationResponse {
  @JsonKey(name: 'GetQROperationResponse')
  final GetQROperationResponse response;

  PsHelpPayQROperationResponse(this.response);

  factory PsHelpPayQROperationResponse.fromJson(Map<String, dynamic> json) =>
      _$PsHelpPayQROperationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelpPayQROperationResponseToJson(this);
}

@JsonSerializable()
class GetQROperationResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'PaymentList')
  final TransactiontList paymentList;

  GetQROperationResponse({
    required this.errorCode,
    this.errorText,
    required this.paymentList,
  });

  factory GetQROperationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetQROperationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetQROperationResponseToJson(this);
}

@JsonSerializable()
class TransactiontList {
  @JsonKey(name: 'Count')
  final int operationsCount;

  @JsonKey(name: 'Payment')
  final List<QRTransaction>? qrTransaction;

  TransactiontList({
    required this.operationsCount,
    this.qrTransaction,
  });

  factory TransactiontList.fromJson(Map<String, dynamic> json) =>
      _$TransactiontListFromJson(json);

  Map<String, dynamic> toJson() => _$TransactiontListToJson(this);
}

@JsonSerializable()
class QRTransaction {
  @JsonKey(name: 'PaymentID')
  final int? paymentId;

  @JsonKey(name: 'RequestId')
  final int requestId;

  @JsonKey(name: 'DateTime')
  final String
      transactionDate; //In protocol its DateTime but it crash our dart parser so we need to parse it by ourselves in bloc

  @JsonKey(name: 'ResultDescription')
  final String transactionStatus;

  @JsonKey(name: 'StatusCode')
  final int status;

  @JsonKey(name: 'Note')
  final String?
      transactionInfo; //TODO this sometimes is null in responses but in protolocol is non nullable

  @JsonKey(name: 'Amount')
  final Amount amount;
  // final QRTransaction operationsCount;

  QRTransaction({
    this.paymentId,
    required this.status,
    required this.requestId,
    required this.transactionDate,
    required this.transactionStatus,
    required this.transactionInfo,
    required this.amount,
  });

  factory QRTransaction.fromJson(Map<String, dynamic> json) =>
      _$QRTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$QRTransactionToJson(this);
}

@JsonSerializable()
class Amount {
  @JsonKey(name: 'Currency')
  final int currency;

  @JsonKey(name: 'Value')
  final num value;

  Amount({
    required this.currency,
    required this.value,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);

  Map<String, dynamic> toJson() => _$AmountToJson(this);
}
