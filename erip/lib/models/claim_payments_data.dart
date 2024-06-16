import 'package:bpc_nkfo/data/data.dart';
import 'package:intl/intl.dart';

class ClaimPaymentsData {
  Service service;
  String dateFrom;
  String accNum;
  int claimId;

  ClaimPaymentsData({
    required this.service,
    required this.dateFrom,
    required this.accNum,
    required this.claimId
  });

  List<String> toList() {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final currentDate = dateFormat.format(DateTime.now());

    return <String>[
      'Требование: $claimId',
      service.name,
      'С $dateFrom',
      'По $currentDate'
    ];
  }

}