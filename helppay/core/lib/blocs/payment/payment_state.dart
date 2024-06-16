// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentError extends PaymentState {
  final Object error;

  const PaymentError({required this.error});

  @override
  List<Object> get props => [error];
}

class PaymentErrorDialog extends PaymentState {
  final Object error;

  const PaymentErrorDialog({required this.error});

  @override
  List<Object> get props => [error];
}

class PaymentErrorKomplat extends PaymentState {
  final String? errorMessage;
  final int? errorCode;

  const PaymentErrorKomplat(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class PaymentErrorKomplatDialog extends PaymentState {
  final String? errorMessage;
  final int? errorCode;

  const PaymentErrorKomplatDialog(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class PaymentAdditionInfo extends PaymentState {
  final QrEripData data;

  const PaymentAdditionInfo({
    required this.data,
  });

   @override
  List<Object?> get props => [data];
}

class PaymentInputFields extends PaymentState {
  final int payCode;
  final PayRecordResponse service;
  final AttrRecordResponse? attrRecord;
  final List<Tuple2<String, dynamic>> finishedAttrs;

  const PaymentInputFields(
      {required this.payCode,
      required this.service,
      required this.attrRecord,
      required this.finishedAttrs});

  @override
  List<Object?> get props => [payCode, service, finishedAttrs, attrRecord];
}

class PaymentResult extends PaymentState {
  final PayRecordResponse service;
  final List<AttrRecordRequest> lastAttrs;
  final List<Tuple2<String, dynamic>> finishedAttrs;

  const PaymentResult(
      {required this.service,
      required this.lastAttrs,
      required this.finishedAttrs});

  @override
  List<Object> get props => [service, lastAttrs, finishedAttrs];
}

class PaymentCheckInitial extends PaymentState {
  final List<String> checkBody;
  final PayRecordResponse? service;

  const PaymentCheckInitial({
    required this.checkBody,
    this.service,
  });

  @override
  List<Object?> get props => [checkBody];
}
