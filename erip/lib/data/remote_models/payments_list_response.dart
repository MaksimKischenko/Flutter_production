// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/data/data.dart';
import 'package:flutter/widgets.dart';
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
  final Address? address;

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
  final int paymentStatus;

  @JsonKey(name: 'MemDate')
  final String memDate;

  @JsonKey(name: 'MemNumber')
  final String memNumber;

  @JsonKey(name: 'BankCode')
  final String? bankCode;

  @JsonKey(name: 'AuthorizationType')
  final String authorizationType;

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
    required this.paymentStatus,
    required this.memDate,
    required this.memNumber,
    this.bankCode,
    required this.authorizationType,
  });

  static const Map<int, String> statusesText = {
    2: 'Оплачено',
    1: 'Зарегистрировано, ожидается оплата',
    -1: 'Успешно сторнировано',
    // -2: "Начато сторнирование",
    // -3: "Начата регистрация платежа",
    -4: 'Отмена регистрации',
    -9: 'Возврат начат',
    -10: 'Возврат выполнен',
    -11: 'Ожидание отмены возврата',
  };

  /// get text status of payment
  String get statusText => statusesText[paymentStatus] ?? 'Неизвестно';

  static const Map<int, Color> statusesColor = {
    2: Color(0xff56C58A),
    1: Color(0xffDDE1E9),
    // 1: Color(0xffffffff),
    -1: Color(0xffEC5B5B),
    -2: Color(0xffF8D147),
    // -2: Color(0xffEC5B5B),
    -3: Color(0xff4FD8F1),
    -4: Color(0xff000000),
    -9: Color(0xff845BC4),
    -10: Color(0xff3F00A0),
    -11: Color(0xff661283),
  };

  /// get status color of claim
  Color statusColor() => statusesColor[paymentStatus] ?? const Color(0xffDDE1E9);

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
