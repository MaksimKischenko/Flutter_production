import 'package:helppay_payform_app/data/data.dart';

class CheckScreenParams {
  final List<String>? checkList;
  final int code;
  final String name;
  final AttrRecordResponse suplierName;
  final AttrRecordResponse suplierValueName;

  const CheckScreenParams({
    required this.checkList,
    required this.code,
    required this.name,
    required this.suplierName,
    required this.suplierValueName,
  });
}
