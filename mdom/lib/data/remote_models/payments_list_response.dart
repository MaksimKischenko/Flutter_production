import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
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

  @JsonKey(name: 'Payment')
  final List<Payment>? payments;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  PaymentsListResponse({
    this.payments,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory PaymentsListResponse.fromJson(Map<String, dynamic> json) => _$PaymentsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsListResponseToJson(this);

}

@JsonSerializable()
class Payment {

  @JsonKey(name: 'PaymentId')
  final int id;

  @JsonKey(name: 'ClaimId')
  final int? claimId;

  @JsonKey(name: 'AccNum')
  final String accNum;

  @JsonKey(name: 'FIO')
  final String? fio;

  @JsonKey(name: 'Address')
  final String? address;

  @JsonKey(name: 'PaymentDate')
  final String paymentDate;

  @JsonKey(name: 'Device')
  final Devices? device;

  @JsonKey(name: 'PaymentSum')
  final double paymentSum;

  @JsonKey(name: 'TransferSum')
  final double? transferSum;

  @JsonKey(name: 'CommissionSum')
  final double? commissionSum;

  @JsonKey(name: 'ProductCharacter')
  final String? productCharacter;

  @JsonKey(name: 'ProviderOperId')
  final int? providerOperId;

  @JsonKey(name: 'PaymentStatus')
  final PaymentStatus status;

  @JsonKey(name: 'MemDate')
  final String memDate;

  @JsonKey(name: 'MemNumber')
  final String memNumber;

  @JsonKey(name: 'BankCode')
  final String? bankCode;

  @JsonKey(name: 'AuthorizationType')
  final String? authorizationType;

  Payment({
    required this.id,
    this.claimId,
    required this.accNum,
    this.fio,
    this.address,
    required this.paymentDate,
    this.device,
    required this.paymentSum,
    this.transferSum,
    this.commissionSum,
    this.productCharacter,
    this.providerOperId,
    required this.status,
    required this.memDate,
    required this.memNumber,
    this.bankCode,
    this.authorizationType,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}