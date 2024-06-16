// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'get_qr_check_duplicate_response.g.dart';

@JsonSerializable()
class PsHelpPayGetQRCheckDuplicateResponseWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelpPayQRCheckDuplicateResponse psErip;

  PsHelpPayGetQRCheckDuplicateResponseWrapper(this.psErip);

  factory PsHelpPayGetQRCheckDuplicateResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayGetQRCheckDuplicateResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayGetQRCheckDuplicateResponseWrapperToJson(this);
}

@JsonSerializable()
class PsHelpPayQRCheckDuplicateResponse {
  @JsonKey(name: 'GetQRCheckDuplicateResponse')
  final GetQRCheckDuplicateResponse response;

  PsHelpPayQRCheckDuplicateResponse(this.response);

  factory PsHelpPayQRCheckDuplicateResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayQRCheckDuplicateResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQRCheckDuplicateResponseToJson(this);
}

@JsonSerializable()
class GetQRCheckDuplicateResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'TerminalID')
  final String? terminalId;

  @JsonKey(name: 'PayDate')
  final String?
      dateOfPayment; //In protocol its DateTime but it crash our parser so we need to parse it by ourselves in bloc
  @JsonKey(name: 'PaySumma')
  final double? paymentSum;
  @JsonKey(name: 'KioskReceipt')
  final String? receiptNumber;

  @JsonKey(name: 'Check')
  final Receipt? receipt;

  GetQRCheckDuplicateResponse({
    required this.errorCode,
    this.errorText,
    required this.terminalId,
    required this.dateOfPayment,
    required this.paymentSum,
    required this.receiptNumber,
    required this.receipt,
  });

  factory GetQRCheckDuplicateResponse.fromJson(Map<String, dynamic> json) =>
      _$GetQRCheckDuplicateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetQRCheckDuplicateResponseToJson(this);
}

@JsonSerializable()
class Receipt {
  @JsonKey(name: 'Count')
  final int numberOfLines;

  @JsonKey(name: 'CheckLine')
  final List<CheckLine> checkLine;

  Receipt({required this.numberOfLines, required this.checkLine});

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}

@JsonSerializable(includeIfNull: true)
class CheckLine {
  @JsonKey(name: 'Idx')
  final int lineIndex;

  @JsonKey(name: 'Value')
  final String? lineValue;

  CheckLine({required this.lineIndex, this.lineValue});

  factory CheckLine.fromJson(Map<String, dynamic> json) =>
      _$CheckLineFromJson(json);

  Map<String, dynamic> toJson() => _$CheckLineToJson(this);
}
