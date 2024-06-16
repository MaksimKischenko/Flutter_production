// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/data/data.dart';
import 'package:kotlin_flavor/scope_functions.dart';

class ClaimsFilterData {
  Service? service;
  String? accNum;
  String dateFrom;
  String dateTo;
  int claimsType;

  ClaimsFilterData({
    required this.service,
    this.accNum,
    required this.dateFrom,
    required this.dateTo,
    required this.claimsType
  });

  @override
  String toString() => 'ClaimFilterData(serviceCode=${service?.code}, serviceName=${service?.name}, accNum=$accNum, dateFrom=$dateFrom, dateTo=$dateTo, claimsType=$claimsType)';

  List<String> toList() {
    final tempList = <String>[
      service?.name ?? '',
      'Тип: $claimsType'
    ];
    accNum?.let((it) {
      tempList.add('Лицевой счет: $it');
    });
    tempList
      ..add('С $dateFrom')
      ..add('По $dateTo');
    return tempList;
  }

}