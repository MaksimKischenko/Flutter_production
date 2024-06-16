part of 'check_bloc.dart';

abstract class CheckState extends Equatable {
  const CheckState();
  
  @override
  List<Object?> get props => [];
}

class CheckLoading extends CheckState {}

class CheckInitial extends CheckState {
  final int paymentId;
  final List<String> check;
  final int code;
  final String name;

  const CheckInitial({
    required this.paymentId,
    required this.check,
    required this.code,
    required this.name
  });

  @override
  List<Object?> get props => [paymentId, check, code, name];
}

class CheckError extends CheckState {
  final Object error;

  const CheckError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class CheckErrorKomplat extends CheckState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const CheckErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}
