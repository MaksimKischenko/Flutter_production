import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';

class BasketItemWrapper extends Equatable {
  final PayRecordResponse payment;
  final String serviceName;
  final String accNumName;

  const BasketItemWrapper({
    required this.payment,
    required this.serviceName,
    required this.accNumName,
  });

  @override
  List<Object> get props => [payment, serviceName, accNumName];
}
