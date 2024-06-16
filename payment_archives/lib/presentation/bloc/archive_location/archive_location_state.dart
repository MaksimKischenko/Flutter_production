part of 'archive_location_bloc.dart';

abstract class ArchiveLocationState extends Equatable {
  const ArchiveLocationState();
  
  @override
  List<Object?> get props => [];
}


class ArchiveLocationLoading extends ArchiveLocationState {}

class ArchiveLocationLoaded extends ArchiveLocationState {
  final List<ArchiveLocation> archiveLocations;

  const ArchiveLocationLoaded({
    required this.archiveLocations,
  });

  @override
  List<Object?> get props => [archiveLocations];
}

class ArchiveLocationsDeleteArchiveLocationSuccess extends ArchiveLocationState {}

class ArchiveLocationsEditArchiveLocationSuccess extends ArchiveLocationState {}

class ArchiveLocationsAddArchiveLocationSuccess extends ArchiveLocationState {}

class ArchiveLocationError extends ArchiveLocationState {
  final Object? error;

  const ArchiveLocationError({this.error});

  @override
  List<Object?> get props => [error];
}



