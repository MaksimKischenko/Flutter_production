part of 'all_services_bloc.dart';

abstract class AllServicesEvent extends Equatable {
  const AllServicesEvent();

  @override
  List<Object?> get props => [];
}

class AllServicesInit extends AllServicesEvent {}