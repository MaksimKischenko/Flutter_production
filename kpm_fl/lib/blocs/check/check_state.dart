part of 'check_bloc.dart';

abstract class CheckState extends Equatable {
  const CheckState();
  
  @override
  List<Object?> get props => [];
}

class CheckInitial extends CheckState {}

class CheckLoading extends CheckState {}

class CheckShow extends CheckState {
  final String check;

  const CheckShow({
    required this.check
  });

  @override
  List<Object> get props => [check];
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