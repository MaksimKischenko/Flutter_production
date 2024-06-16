import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_statement_response.g.dart';

@JsonSerializable()
class MdomAccountStatementResponseWrapper {

  @JsonKey(name: 'TPInfoResponse')
  final MdomAccountStatementResponse response;

  MdomAccountStatementResponseWrapper(this.response);

  factory MdomAccountStatementResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomAccountStatementResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomAccountStatementResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomAccountStatementResponse {

  @JsonKey(name: 'RequestType')
  final String? requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomTpInfoErrorCode? errorCode;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Params')
  final MdomTpInfoResponseParams? params;

  @JsonKey(name: 'Lookups')
  final MdomTpInfoLookups? lookups;

  @JsonKey(name: 'PeriodInfo')
  final List<AccountStatementPeriod>? periods;

  const MdomAccountStatementResponse({
    this.requestType,
    this.errorCode,
    required this.token,
    this.params,
    this.lookups,
    required this.periods
  });

  factory MdomAccountStatementResponse.fromJson(Map<String, dynamic> json) => _$MdomAccountStatementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomAccountStatementResponseToJson(this);
  
}

@JsonSerializable()
class AccountStatementPeriod extends Equatable {

  @JsonKey(name: '@Period')
  final String value;

  @JsonKey(name: 'Services')
  final ServicesWrapper? servicesWrapper;

  @JsonKey(name: 'Payments')
  final PaymentsWrapper? paymentsWrapper;
  
  const AccountStatementPeriod({
    required this.value,
    this.servicesWrapper,
    this.paymentsWrapper,
  });

  factory AccountStatementPeriod.fromJson(Map<String, dynamic> json) => _$AccountStatementPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$AccountStatementPeriodToJson(this);

  @override
  List<Object?> get props => [
    value,
    servicesWrapper,
    paymentsWrapper,
  ];
}

@JsonSerializable()
class ServicesWrapper {

  @JsonKey(name: 'Service')
  final List<MdomService>? services;
  
  const ServicesWrapper({
    this.services,
  });

  factory ServicesWrapper.fromJson(Map<String, dynamic> json) => _$ServicesWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesWrapperToJson(this);
  
}

@JsonSerializable()
class MdomService extends Equatable {

  @JsonKey(name: '@ID')
  final int? id;

  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Unit')
  final String? unit;

  @JsonKey(name: '@ClaimId')
  final int? claimId;

  @JsonKey(name: '@DateBegin')
  final String? dateBegin;

  @JsonKey(name: '@DateEnd')
  final String? dateEnd;

  @JsonKey(name: '@PayAmount')
  final double? payAmount;

  @JsonKey(name: '@Volume')
  final double? volume;

  @JsonKey(name: '@Tariff')
  final double? tariff;

  @JsonKey(name: '@Balance')
  final double? balance;

  @JsonKey(name: '@Accrued')
  final double accrued;

  @JsonKey(name: '@Benefit')
  final double? benefit;

  @JsonKey(name: '@Recalculated')
  final double? recalculated;

  @JsonKey(name: '@Fine')
  final double? fine;

  @JsonKey(name: '@Total')
  final double total;

  const MdomService({
    this.id,
    required this.name,
    this.unit,
    required this.claimId,
    required this.dateBegin,
    required this.dateEnd,
    required this.payAmount,
    this.volume,
    this.tariff,
    this.balance,
    required this.accrued,
    this.benefit,
    this.recalculated,
    this.fine,
    required this.total,
  });


  factory MdomService.fromJson(Map<String, dynamic> json) => _$MdomServiceFromJson(json);

  Map<String, dynamic> toJson() => _$MdomServiceToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    unit,
    claimId,
    dateBegin,
    dateEnd,
    payAmount,
    volume,
    tariff,
    balance,
    accrued,
    benefit,
    recalculated,
    fine,
    total,
  ];

  MdomService copyWith({
    int? id,
    String? name,
    String? unit,
    int? claimId,
    String? dateBegin,
    String? dateEnd,
    double? payAmount,
    double? volume,
    double? tariff,
    double? balance,
    double? accrued,
    double? benefit,
    double? recalculated,
    double? fine,
    double? total,
  }) => MdomService(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      claimId: claimId ?? this.claimId,
      dateBegin: dateBegin ?? this.dateBegin,
      dateEnd: dateEnd ?? this.dateEnd,
      payAmount: payAmount ?? this.payAmount,
      volume: volume ?? this.volume,
      tariff: tariff ?? this.tariff,
      balance: balance ?? this.balance,
      accrued: accrued ?? this.accrued,
      benefit: benefit ?? this.benefit,
      recalculated: recalculated ?? this.recalculated,
      fine: fine ?? this.fine,
      total: total ?? this.total,
    );
}

@JsonSerializable()
class PaymentsWrapper {

  @JsonKey(name: 'Payment')
  final List<PaymentBilling>? payments;
  
  const PaymentsWrapper({
    this.payments,
  });

  factory PaymentsWrapper.fromJson(Map<String, dynamic> json) => _$PaymentsWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsWrapperToJson(this);
  
}

@JsonSerializable()
class PaymentBilling extends Equatable {

  @JsonKey(name: '@PaymentId')
  final String id;

  @JsonKey(name: '@DatePay')
  final String datePay;

  @JsonKey(name: '@ClaimId')
  final int? claimId;

  @JsonKey(name: '@InfoPay')
  final String? infoPay;

  @JsonKey(name: '@Amount')
  final double amount;

  @JsonKey(name: '@FineAmount')
  final double fineAmount;

  @JsonKey(name: '@ServiceAmount')
  final double serviceAmount;

  const PaymentBilling({
    required this.id,
    required this.datePay,
    required this.claimId,
    this.infoPay,
    required this.amount,
    required this.fineAmount,
    required this.serviceAmount,
  });
  

  factory PaymentBilling.fromJson(Map<String, dynamic> json) => _$PaymentBillingFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentBillingToJson(this);
  

  @override
  List<Object?> get props => [
    id,
    datePay,
    infoPay,
    amount,
    claimId,
    fineAmount,
    serviceAmount,
  ];
}
