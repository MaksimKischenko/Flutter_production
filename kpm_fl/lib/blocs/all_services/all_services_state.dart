part of 'all_services_bloc.dart';

abstract class AllServicesState extends Equatable {
  const AllServicesState();
  
  @override
  List<Object?> get props => [];
}

class AllServicesLoading extends AllServicesState {}

class AllServicesError extends AllServicesState {
  final Object error;

  const AllServicesError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class AllServicesErrorKomplat extends AllServicesState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const AllServicesErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}

class AllServicesLoaded extends AllServicesState {
  final List<EripService> services;

  const AllServicesLoaded({
    required this.services
  });

  @override
  List<Object?> get props => [services];
}

