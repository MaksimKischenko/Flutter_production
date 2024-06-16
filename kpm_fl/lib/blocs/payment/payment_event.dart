part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentGetInfo extends PaymentEvent {
  final int code;

  const PaymentGetInfo(
    this.code
  );

  @override
  List<Object> get props => [code];
}

class PaymentInputFieldsFinished extends PaymentEvent {
  final int payCode;
  final PayRecordResponse service;
  final List<AttrRecordRequest> attrsEdited;
  final double? sum;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final List<ResponseClaimProperty> properties;

  const PaymentInputFieldsFinished({
    required this.payCode,
    required this.service,
    required this.attrsEdited,
    this.sum,
    required this.finishedAttrs,
    required this.properties
  });

  @override
  String toString() => 'PaymentInputFieldsFinished { payCode: $payCode }';
}

class PaymentFinish extends PaymentEvent {}