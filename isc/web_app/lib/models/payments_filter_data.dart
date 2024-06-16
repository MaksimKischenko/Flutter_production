// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartx/dartx.dart';

import 'models.dart';

class PaymentsFilterData {
  int? serviceCode;
  String? accNum;
  PaymentDateType dateType;  
  DateTime dateFrom;
  DateTime dateTo;
  PaymentStatus status;
  int? claimId;

  PaymentsFilterData({
    required this.serviceCode,
    required this.dateFrom,
    required this.dateType,
    required this.dateTo,
    required this.status,
    this.claimId,
    this.accNum
  });

  factory PaymentsFilterData.empty({
    int? serviceCode,
  }) => PaymentsFilterData(
    serviceCode: serviceCode,
    dateType: PaymentDateType.transfer,    
    dateFrom: DateTime(DateTime.now().year, DateTime.now().month, 01),
    dateTo: DateTime.now(),
    status: PaymentStatus.all,
  );

  @override
  String toString() => 'PaymentsFilterData(serviceCode=$serviceCode, accNum=$accNum, dateFrom=$dateFrom, dateTo=$dateTo)';

  List<String> toList() => [
    dateType.name,
    if (accNum.isNullOrBlank)
    'Лицевой счет: $accNum',
    'С $dateFrom',
    'По $dateTo'
  ];


  PaymentsFilterData copyWith({
    int? serviceCode,
    String? accNum,
    PaymentDateType? dateType,
    DateTime? dateFrom,
    DateTime? dateTo,
    PaymentStatus? status,
    int? claimId,
  }) => PaymentsFilterData(
      serviceCode: serviceCode ?? this.serviceCode,
      accNum: accNum ?? this.accNum,
      dateType: dateType ?? this.dateType,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      status: status ?? this.status,
      claimId: claimId ?? this.claimId,
    );
}
