import 'package:bpc/data/data.dart';
import 'package:dartx/dartx.dart';

import 'claim_status.dart';

class ClaimsFilterData {
  Service? service;
  String? accNum;
  DateTime dateFrom;
  DateTime dateTo;
  ClaimStatus status;

  ClaimsFilterData({
    required this.service,
    this.accNum,
    required this.dateFrom,
    required this.dateTo,
    required this.status
  });

  factory ClaimsFilterData.empty({
    Service? service,
  }) => ClaimsFilterData(
    service: service,
    // dateFrom: DateTime.now().subtract(const Duration(days: 900)),
    dateFrom: DateTime.now(),
    dateTo: DateTime.now(),
    status: ClaimStatus.all,
  );

  @override
  String toString() => 'ClaimFilterData(serviceCode=${service?.code}, serviceName=${service?.name}, accNum=$accNum, dateFrom=$dateFrom, dateTo=$dateTo, status=$status)';

  List<String> toList() => [
    service?.name ?? '',
    'Тип: ${status.name}',
    if (accNum.isNullOrBlank)
    'Лицевой счет: $accNum',
    'С $dateFrom',
    'По $dateTo',
  ];

}