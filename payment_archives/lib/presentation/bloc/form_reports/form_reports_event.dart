// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'form_reports_bloc.dart';

abstract class FormReportsEvent extends Equatable {
  const FormReportsEvent();

  @override
  List<Object?> get props => [];
}

class FormReportsInit extends FormReportsEvent {
  final List<Payment> payments;
  final SearchPaymentData requestData;
  final ReportsTypes reportsType;

  const FormReportsInit({
    required this.payments,
    required this.requestData,
    required this.reportsType
  });

  @override
  List<Object?> get props => [requestData, payments, reportsType];
}
