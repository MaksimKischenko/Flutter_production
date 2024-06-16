part of 'all_services_node_bloc.dart';

abstract class AllServicesNodeState extends Equatable {
  const AllServicesNodeState();
  
  @override
  List<Object?> get props => [];
}

class AllServicesNodeInitial extends AllServicesNodeState {}

class AllServicesNodeLoading extends AllServicesNodeState {}

class AllServicesNodeError extends AllServicesNodeState {
  final Object error;

  const AllServicesNodeError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class AllServicesNodeErrorKomplat extends AllServicesNodeState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const AllServicesNodeErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}

class AllServicesNodeLoaded extends AllServicesNodeState {
  final List<EripService> services;

  const AllServicesNodeLoaded({
    required this.services
  });

  @override
  List<Object?> get props => [services];
}
