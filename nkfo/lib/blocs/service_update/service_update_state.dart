part of 'service_update_bloc.dart';

abstract class ServiceUpdateState extends Equatable {
  const ServiceUpdateState();
  
  @override
  List<Object?> get props => [];
}

class ServiceUpdateInitial extends ServiceUpdateState {
  final SupplierAccount service;
  final List<Bank> banks;
  final List<ServiceScenario> scenarios;

  const ServiceUpdateInitial({
    required this.service,
    required this.banks,
    required this.scenarios
  });

  @override
  List<Object> get props => [service, banks, scenarios];
}

class ServiceUpdateInitLoading extends ServiceUpdateState {}

class ServiceUpdateInitError extends ServiceUpdateState {
  final Object? error;

  const ServiceUpdateInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServiceUpdateLoading extends ServiceUpdateState {}

class ServiceUpdateError extends ServiceUpdateState {
  final Object? error;

  const ServiceUpdateError({this.error});

  @override
  List<Object?> get props => [error];
}

class ServiceUpdateSuccess extends ServiceUpdateState {
  final SupplierAccount? service;

  const ServiceUpdateSuccess({
    required this.service
  });

  @override
  List<Object?> get props => [service];
}