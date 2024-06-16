part of 'init_helppay_services_bloc.dart';

abstract class InitHelppayServicesState extends Equatable {
  const InitHelppayServicesState();

  @override
  List<Object?> get props => [];
}

class InitHelppayServicesLoading extends InitHelppayServicesState {}

class InitHelppayServicesError extends InitHelppayServicesState {
  final Object error;

  const InitHelppayServicesError({required this.error});

  @override
  List<Object?> get props => [error];
}

class InitHelppayServicesErrorKomplat extends InitHelppayServicesState {
  final int? errorCode;
  final String? errorText;

  const InitHelppayServicesErrorKomplat(
      {required this.errorCode, required this.errorText});

  @override
  List<Object?> get props => [errorCode, errorText];
}

class InitHelppayServicesLoaded extends InitHelppayServicesState {
  final List<Service> services;

  const InitHelppayServicesLoaded({required this.services});

  @override
  List<Object?> get props => [services];
}

class InitHelppayNodesLoaded extends InitHelppayServicesState {
  final List<Service?> servicesList;
  final List<Service?> routeMap;

  const InitHelppayNodesLoaded({
    required this.servicesList,
    required this.routeMap,
  });

  @override
  List<Object?> get props => [servicesList, routeMap];
}
