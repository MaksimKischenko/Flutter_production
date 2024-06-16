part of 'service_update_bloc.dart';

abstract class ServiceUpdateEvent extends Equatable {
  const ServiceUpdateEvent();

  @override
  List<Object> get props => [];
}

class ServiceUpdateInit extends ServiceUpdateEvent {}

class ServiceUpdateRun extends ServiceUpdateEvent {
  final SupplierAccountUpdateRequest service;

  const ServiceUpdateRun(this.service);

  @override
  List<Object> get props => [service];
}
