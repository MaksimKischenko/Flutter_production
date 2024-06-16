import 'package:bpc/data/data.dart';
import 'package:dartx/dartx.dart';

import 'models.dart';

class PaymentsFilterData {
  Service? service;
  PaymentDateType dateType;
  String? accNum;
  DateTime dateFrom;
  DateTime dateTo;
  PaymentStatus status;
  int? claimId;

  PaymentsFilterData({
    required this.service,
    required this.dateType,
    this.accNum,
    required this.dateFrom,
    required this.dateTo,
    required this.status,
    this.claimId
  });

  factory PaymentsFilterData.empty({
    Service? service,
  }) => PaymentsFilterData(
    service: service,
    dateType: PaymentDateType.transfer,
    // dateFrom: DateTime.now().subtract(const Duration(days: 900)),
    dateFrom: DateTime.now(),
    dateTo: DateTime.now(),
    status: PaymentStatus.all,
  );

  @override
  String toString() => 'PaymentsFilterData(serviceCode=${service?.code}, serviceName=${service?.name}, dateType=$dateType, accNum=$accNum, dateFrom=$dateFrom, dateTo=$dateTo)';

  List<String> toList() => [
    service?.name ?? '',
    dateType.name,
    if (accNum.isNullOrBlank)
    'Лицевой счет: $accNum',
    'С $dateFrom',
    'По $dateTo'
  ];

}