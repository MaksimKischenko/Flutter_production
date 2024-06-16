part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentRequestLoading extends PaymentState {}

class PaymentError extends PaymentState {
  final Object error;

  const PaymentError({required this.error});

  @override
  List<Object?> get props => [error];
}

class PaymentErrorDialog extends PaymentState {
  final Object error;

  const PaymentErrorDialog({required this.error});

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
    required this.errorText,
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
    required this.errorText,
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}

class PaymentInputFields extends PaymentState {
  final int payCode;
  final double remainingAmount;
  final PayRecordResponse service;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final List<ResponseClaimProperty> properties;

  const PaymentInputFields({
    required this.payCode,
    required this.remainingAmount,
    required this.service,
    required this.finishedAttrs,
    required this.properties,
  });

  @override
  List<Object?> get props =>
      [payCode, remainingAmount, service, finishedAttrs, properties];
}

class PaymentResult extends PaymentState {
  final PayRecordResponse service;
  final int diType;
  final List<AttrRecordRequest> lastAttrs;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final List<ResponseClaimProperty> properties;

  const PaymentResult(
      {required this.service,
      required this.diType,
      required this.lastAttrs,
      required this.finishedAttrs,
      required this.properties});

  @override
  List<Object?> get props =>
      [service, diType, lastAttrs, finishedAttrs, properties];
}

class PaymentSuccess extends PaymentState {
  final int paymentId;
  final List<String> checkList;
  final AttrRecordResponse suplierName;
  final AttrRecordResponse suplierValueName;

  const PaymentSuccess({
    required this.paymentId,
    required this.checkList,
    required this.suplierName,
    required this.suplierValueName,
  });

  @override
  List<Object?> get props => [paymentId, checkList];
}
