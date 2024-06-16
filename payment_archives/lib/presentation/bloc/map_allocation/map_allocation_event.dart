part of 'map_allocation_bloc.dart';

abstract class MapAllocationEvent extends Equatable {
  const MapAllocationEvent();

  @override
  List<Object> get props => [];
}

class MapAllocationInit extends MapAllocationEvent {}

class MapAllocationSort extends MapAllocationEvent {

  final bool ascending;
  final int sortIndex;

  const MapAllocationSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];
}
