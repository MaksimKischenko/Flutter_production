import 'package:bpc/data/data.dart';
import 'package:bpc/utils/utils.dart';

class ClaimPaymentsData {
  Service service;
  DateTime dateFrom;
  String accNum;
  int claimId;

  ClaimPaymentsData({
    required this.service,
    required this.dateFrom,
    required this.accNum,
    required this.claimId
  });

  List<String> toList() => <String>[
    'Требование: $claimId',
    service.name,
    'С ${dateFrom.toStringFormatted()}',
    'По ${DateTime.now().toStringFormatted()}'
  ];

}