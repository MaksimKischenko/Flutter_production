// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/data/data.dart';
import 'package:kotlin_flavor/scope_functions.dart';

class PaymentsFilterData {
  Service? service;
  int dateType;
  String? accNum;
  String dateFrom;
  String dateTo;
  int? paymentsType;
  int? claimId;

  PaymentsFilterData({
    required this.service,
    required this.dateType,
    this.accNum,
    required this.dateFrom,
    required this.dateTo,
    this.paymentsType,
    this.claimId
  });

  @override
  String toString() => 'PaymentsFilterData(serviceCode=${service?.code}, serviceName=${service?.name}, dateType=$dateType, accNum=$accNum, dateFrom=$dateFrom, dateTo=$dateTo)';

  List<String> toList() {
    final tempList = <String>[
      service?.name ?? '',
      dateTypeStr[dateType]!
    ];
    accNum?.let((it) {
      tempList.add('Лицевой счет: $it');
    });
    tempList
      ..add('С $dateFrom')
      ..add('По $dateTo');
    return tempList;
  }

  Map<int, String> dateTypeStr = {
    0: 'Дата перечисления',
    1: 'Дата приема платежа'
  };
}