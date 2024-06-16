// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:isc_web_app/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payments_list_response.g.dart';

@JsonSerializable()
class PsTpOPaymentsListResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOPaymentsListResponse psTpO;

  PsTpOPaymentsListResponseWrapper(this.psTpO);

  factory PsTpOPaymentsListResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOPaymentsListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOPaymentsListResponseWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOPaymentsListResponse {

  @JsonKey(name: 'PaymentsListResponse')
  final PaymentsListResponse response;

  PsTpOPaymentsListResponse(this.response);

  factory PsTpOPaymentsListResponse.fromJson(Map<String, dynamic> json) => _$PsTpOPaymentsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOPaymentsListResponseToJson(this);
  
}

@JsonSerializable()
class PaymentsListResponse {

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'RowNum')
  final int? rowNum;

  @JsonKey(name: 'Payment')
  final List<PaymentISC>? payments;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  PaymentsListResponse({
    required this.version,
    required this.key,
    this.rowNum,
    this.payments,
    required this.errorCode,
    this.errorText,
  });

  factory PaymentsListResponse.fromJson(Map<String, dynamic> json) => _$PaymentsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsListResponseToJson(this);

}

@JsonSerializable()
class PaymentISC {

  @JsonKey(name: 'PaymentId')
  final int id;

  @JsonKey(name: 'ClaimId')
  final int? claimId;

  @JsonKey(name: 'AccNum')
  final String? accNum;

  @JsonKey(name: 'FIO')
  final String? fio;

  @JsonKey(name: 'Address')
  final String? address;

  @JsonKey(name: 'PaymentDate')
  final String paymentDate;

  @JsonKey(name: 'PaymentSum')
  final double paymentSum;

  @JsonKey(name: 'ProductCharacter')
  final String? productCharacter;

  @JsonKey(name: 'BankCode')
  final String? bankCode;

  @JsonKey(name: 'Account')
  final String? account;

  @JsonKey(name: 'MemDate')
  final String memDate;

  @JsonKey(name: 'MemNumber')
  final String memNumber;

  @JsonKey(name: 'PaymentStatus')
  final PaymentStatus status;

  PaymentISC({
    required this.id,
    this.claimId,
    required this.accNum,
    this.fio,
    this.address,
    required this.paymentDate,
    required this.paymentSum,
    this.productCharacter,
    this.bankCode,
    this.account,
    required this.memDate,
    required this.memNumber,
    required this.status,
  });

  factory PaymentISC.fromJson(Map<String, dynamic> json) => _$PaymentISCFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentISCToJson(this);
}
