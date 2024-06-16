part of 'archive_location_update_bloc.dart';

abstract class ArchiveLocationUpdateState extends Equatable {
  const ArchiveLocationUpdateState();
  
  @override
  List<Object?> get props => [];
}

class ArchiveLocationUpdateInitial extends ArchiveLocationUpdateState {
  final ArchiveLocation? archiveLocation;

  const ArchiveLocationUpdateInitial({
    required this.archiveLocation,
  });

  @override
  List<Object?> get props => [archiveLocation];
}


class ArchiveLocationUpdateLoading extends ArchiveLocationUpdateState {}

class ArchiveLocationUpdateSuccess extends ArchiveLocationUpdateState {
  final ArchiveLocation? archiveLocation;

  const ArchiveLocationUpdateSuccess({required this.archiveLocation});

  @override
  List<Object?> get props => [archiveLocation];
}


class ArchiveLocationUpdateNetworkError extends ArchiveLocationUpdateState {
  final Object? error;

  const ArchiveLocationUpdateNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}
