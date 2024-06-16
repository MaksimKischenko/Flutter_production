// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartx/dartx.dart';

import 'claim_status.dart';

class ClaimsFilterData {
  int? serviceCode;
  String? accNum;
  DateTime dateFrom;
  DateTime dateTo;
  ClaimStatus status;

  ClaimsFilterData({
    this.serviceCode,
    this.accNum,
    required this.dateFrom,
    required this.dateTo,
    required this.status,
  });


  factory ClaimsFilterData.empty({
    int? serviceCode
  }) => ClaimsFilterData(
    serviceCode: serviceCode,
    dateFrom: DateTime(DateTime.now().year, DateTime.now().month, 01),
    dateTo: DateTime.now(),
    status: ClaimStatus.all,
  );

  @override
  String toString() => 'ClaimFilterData(serviceCode=$serviceCode, accNum=$accNum, dateFrom=$dateFrom, dateTo=$dateTo, status=$status)';

  List<String> toList() => [
    'Тип: ${status.name}',
    if (accNum.isNullOrBlank)
    'Лицевой счет: $accNum',
    'С $dateFrom',
    'По $dateTo',
  ];

  ClaimsFilterData copyWith({
    int? serviceCode,
    String? accNum,
    DateTime? dateFrom,
    DateTime? dateTo,
    ClaimStatus? status,
  }) => ClaimsFilterData(
      serviceCode: serviceCode ?? this.serviceCode,
      accNum: accNum ?? this.accNum,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      status: status ?? this.status,
    );
}
