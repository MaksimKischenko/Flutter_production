part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class ServicesInit extends ServicesEvent {
  final int code;

  const ServicesInit(this.code);

  @override
  List<Object> get props => [code];
}