part of 'service_insert_bloc.dart';

abstract class ServiceInsertState extends Equatable {
  const ServiceInsertState();
  
  @override
  List<Object?> get props => [];
}

class ServiceInsertInitial extends ServiceInsertState {
  final List<Bank> banks;
  final List<ServiceScenario> scenarios;

  const ServiceInsertInitial({
    required this.banks,
    required this.scenarios
  });

  @override
  List<Object?> get props => [banks, scenarios];
}

class ServiceInsertInitLoading extends ServiceInsertState {}

class ServiceInsertInitError extends ServiceInsertState {
  final Object? error;

  const ServiceInsertInitError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ServiceInsertLoading extends ServiceInsertState {}

class ServiceInsertError extends ServiceInsertState {
  final Object? error;

  const ServiceInsertError({this.error});

  @override
  List<Object?> get props => [error];
}

class ServiceInsertSuccess extends ServiceInsertState {
  final SupplierAccount? account;

  const ServiceInsertSuccess({
    required this.account
  });

  @override
  List<Object?> get props => [account];
}
