part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  
  @override
  List<Object?> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentError extends PaymentState {
  final Object error;

  const PaymentError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class PaymentErrorDialog extends PaymentState {
  final Object error;

  const PaymentErrorDialog({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class PaymentErrorKomplat extends PaymentState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const PaymentErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}

class PaymentErrorKomplatDialog extends PaymentState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const PaymentErrorKomplatDialog({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}

class PaymentInputFields extends PaymentState {
  final int payCode;
  final PayRecordResponse service;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final List<ResponseClaimProperty> properties;

  const PaymentInputFields({
    required this.payCode,
    required this.service,
    required this.finishedAttrs,
    required this.properties
  });

  @override
  List<Object?> get props => [payCode, service, finishedAttrs, properties];
}

class PaymentResult extends PaymentState {
  final PayRecordResponse service;
  final List<AttrRecordRequest> lastAttrs;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final List<ResponseClaimProperty> properties;

  const PaymentResult({
    required this.service,
    required this.lastAttrs,
    required this.finishedAttrs,
    required this.properties
  });

  @override
  List<Object?> get props => [service, lastAttrs, finishedAttrs, properties];
}

class PaymentSuccess extends PaymentState {
  final PayRecordResponse payment;
  final String serviceName;
  final String accNumName;
  // final int paymentId;
  // final List<String> checkList;

  const PaymentSuccess({
    required this.payment,
    required this.serviceName,
    required this.accNumName
    // required this.checkList
  });

  @override
  List<Object?> get props => [
    payment,
    serviceName,
    accNumName,
  ];
}