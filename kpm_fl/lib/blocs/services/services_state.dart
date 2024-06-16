part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
  
  @override
  List<Object?> get props => [];
}

class ServicesLoading extends ServicesState {}

class ServicesError extends ServicesState {
  final Object error;

  const ServicesError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServicesErrorKomplat extends ServicesState {
  final int lastCode;
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const ServicesErrorKomplat({
    required this.lastCode,
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [lastCode, request, errorCode, errorText];
}

class ServicesLoaded extends ServicesState {
  final List<PayRecordResponse> payRecords;

  const ServicesLoaded({
    required this.payRecords
  });

  @override
  List<Object?> get props => [payRecords];
}