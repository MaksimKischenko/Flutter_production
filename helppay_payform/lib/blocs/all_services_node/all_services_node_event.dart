part of 'all_services_node_bloc.dart';

abstract class AllServicesNodeEvent extends Equatable {
  const AllServicesNodeEvent();

  @override
  List<Object> get props => [];
}

class AllServicesNodeInit extends AllServicesNodeEvent {}