part of 'check_connection_bloc.dart';

abstract class CheckConnectionState extends Equatable {
  const CheckConnectionState();
  
  @override
  List<Object?> get props => [];
}

class CheckConnectionLoading extends CheckConnectionState {}

class CheckConnectionSuccess extends CheckConnectionState {}

class CheckConnectionError extends CheckConnectionState {
  final Object error;

  const CheckConnectionError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class CheckConnectionErrorKomplat extends CheckConnectionState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const CheckConnectionErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}