
part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentGetInfo extends PaymentEvent {
  final QrEripData data;

  const PaymentGetInfo(
    this.data
  );

  @override
  String toString() => 'PaymentEvent {data: $data }';
}

class PaymentInputFieldsFinished extends PaymentEvent {
  final int payCode;
  final PayRecordResponse service;
  final List<AttrRecordRequest> attrsEdited;
  final double? sum;
  final List<Tuple2<String, dynamic>> finishedAttrs;

  const PaymentInputFieldsFinished({
    required this.payCode,
    required this.service,
    required this.attrsEdited,
    this.sum,
    required this.finishedAttrs
  });

  @override
  String toString() => 'PaymentInputFieldsFinished { payCode: $payCode }';
}

class PaymentRunOperation extends PaymentEvent {
  final PayRecordResponse service;
  final List<AttrRecordRequest> attrs;

  const PaymentRunOperation({
    required this.service,
    required this.attrs,
  });
}

