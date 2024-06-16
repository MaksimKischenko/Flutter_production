part of 'available_archive_location_bloc.dart';

abstract class AvailableArchiveLocationState extends Equatable {
  const AvailableArchiveLocationState();
  
  @override
  List<Object?> get props => [];
}

class AvailableArchiveLocationLoading extends AvailableArchiveLocationState {}

class AvailableArchiveLocationLoaded extends AvailableArchiveLocationState {
  final List<AvailableArchiveLocation> archiveLocations;

  const AvailableArchiveLocationLoaded({
    required this.archiveLocations,
  });

  @override
  List<Object?> get props => [archiveLocations];
}

class AvailableArchiveLocationError extends AvailableArchiveLocationState {
  final Object? error;

  const AvailableArchiveLocationError({this.error});

  @override
  List<Object?> get props => [error];
}


