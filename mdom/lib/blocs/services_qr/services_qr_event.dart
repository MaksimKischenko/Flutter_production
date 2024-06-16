part of 'services_qr_bloc.dart';

abstract class ServicesQrEvent extends Equatable {
  const ServicesQrEvent();

  @override
  List<Object> get props => [];
}

class ServicesQrInit extends ServicesQrEvent {}

class ServicesQrSelected extends ServicesQrEvent {
  final Service service;

  const ServicesQrSelected(this.service);

  @override
  List<Object> get props => [service.code, service.name];
}