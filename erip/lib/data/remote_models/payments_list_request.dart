// ignore_for_file: always_put_required_named_parameters_first

import 'package:json_annotation/json_annotation.dart';

part 'payments_list_request.g.dart';

@JsonSerializable()
class PsTpOPaymentsListRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOPaymentsListRequest psTpO;

  PsTpOPaymentsListRequestWrapper(this.psTpO);

  factory PsTpOPaymentsListRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOPaymentsListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOPaymentsListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpOPaymentsListRequest {

  @JsonKey(name: 'PaymentsListRequest')
  final PaymentsListRequest request;

  PsTpOPaymentsListRequest(this.request);

  factory PsTpOPaymentsListRequest.fromJson(Map<String, dynamic> json) => _$PsTpOPaymentsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOPaymentsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class PaymentsListRequest {

  @JsonKey(name: 'DateType')
  final int dateType;

  @JsonKey(name: 'DateFrom')
  final String dateFrom;

  @JsonKey(name: 'DateTo')
  final String dateTo;

  //optional
  @JsonKey(name: 'AccNum')
  final String? accNum;

  //optional
  @JsonKey(name: 'PaymentStatus')
  final int? status;

  //optional
  @JsonKey(name: 'ClaimId')
  final int? claimId;

  //optional
  @JsonKey(name: 'LastPayment')
  final int? lastPayment;

  @JsonKey(name: 'ServiceCode')
  final int serviceCode;

  @JsonKey(name: 'RowCount')
  final RowCountPayments? rowCount;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'KeyRequest')
  final int key;

  PaymentsListRequest({
    required this.dateType,
    required this.dateFrom,
    required this.dateTo,
    this.accNum,
    this.status,
    this.claimId,
    this.lastPayment,
    required this.serviceCode,
    this.rowCount,
    required this.version,
    required this.token,
    required this.key,
  });

  factory PaymentsListRequest.fromJson(Map<String, dynamic> json) => _$PaymentsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsListRequestToJson(this);
  
}

@JsonSerializable()
class RowCountPayments {

  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@PaymentId')
  final int? paymentId;

  RowCountPayments({
    required this.evalue,
    this.paymentId,
  });
  
  factory RowCountPayments.fromJson(Map<String, dynamic> json) => _$RowCountPaymentsFromJson(json);

  Map<String, dynamic> toJson() => _$RowCountPaymentsToJson(this);

}
