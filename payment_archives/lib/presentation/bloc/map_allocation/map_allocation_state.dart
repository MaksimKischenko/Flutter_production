part of 'map_allocation_bloc.dart';

abstract class MapAllocationState extends Equatable {
  const MapAllocationState();
  
  @override
  List<Object?> get props => [];
}

class MapAllocationLoading extends MapAllocationState {}

class MapAllocationLoaded extends MapAllocationState {
  final List<MapAllocationData> mapAllocations;

  const MapAllocationLoaded({
    required this.mapAllocations,
  });

  @override
  List<Object?> get props => [mapAllocations];  
}

class MapAllocationError extends MapAllocationState {
  final Object? error;

  const MapAllocationError({this.error});

  @override
  List<Object?> get props => [error];
}
