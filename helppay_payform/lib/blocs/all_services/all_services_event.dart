part of 'all_services_bloc.dart';

abstract class AllServicesEvent extends Equatable {
  const AllServicesEvent();

  @override
  List<Object?> get props => [];
}

class AllServicesInit extends AllServicesEvent {
  final String? name;
  final List<FilterAttrRecord>? filters;
  
  const AllServicesInit({
    this.name,
    this.filters
  });

  @override
  List<Object?> get props => [name, filters];
}