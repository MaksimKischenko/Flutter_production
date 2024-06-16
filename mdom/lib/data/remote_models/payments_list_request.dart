import 'package:bpc/models/models.dart';
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

  // general part

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  // general part END

  @JsonKey(name: 'DateType')
  final PaymentDateType dateType;

  @JsonKey(name: 'DateFrom')
  final String dateFrom;

  @JsonKey(name: 'DateTo')
  final String dateTo;

  //optional
  @JsonKey(name: 'AccNum')
  final String? accNum;

  //optional
  @JsonKey(name: 'PaymentStatus')
  final PaymentStatus? status;

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

  const PaymentsListRequest({
    required this.version,
    required this.key,
    required this.token,
    required this.terminalId,
    required this.dateType,
    required this.dateFrom,
    required this.dateTo,
    this.accNum,
    this.status,
    this.claimId,
    this.lastPayment,
    required this.serviceCode,
    this.rowCount,
  });

  factory PaymentsListRequest.fromJson(Map<String, dynamic> json) => _$PaymentsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
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
