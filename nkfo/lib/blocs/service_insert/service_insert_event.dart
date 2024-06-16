part of 'service_insert_bloc.dart';

abstract class ServiceInsertEvent extends Equatable {
  const ServiceInsertEvent();

  @override
  List<Object> get props => [];
}

class ServiceInsertInit extends ServiceInsertEvent {}

class ServiceInsertRun extends ServiceInsertEvent {
  final SupplierAccountInsertRequest account;

  const ServiceInsertRun(this.account);

  @override
  List<Object> get props => [account];
}