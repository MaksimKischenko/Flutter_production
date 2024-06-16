part of 'popular_services_bloc.dart';

abstract class PopularServicesEvent extends Equatable {
  const PopularServicesEvent();

  @override
  List<Object> get props => [];
}

class PopularServicesInit extends PopularServicesEvent {}