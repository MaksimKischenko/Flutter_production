part of 'archive_location_insert_bloc.dart';

abstract class ArchiveLocationInsertState extends Equatable {
  const ArchiveLocationInsertState();
  
  @override
  List<Object?> get props => [];
}

class ArchiveLocationInsertLoading extends ArchiveLocationInsertState {}

class ArchiveLocationInsertInitial extends ArchiveLocationInsertState {}

class ArchiveLocationInsertSuccess extends ArchiveLocationInsertState {
  final ArchiveLocation archiveLocation;

  const ArchiveLocationInsertSuccess({
    required this.archiveLocation,
  });

  @override
  List<Object?> get props => [archiveLocation];
}

class ArchiveLocationInsertNetworkError extends ArchiveLocationInsertState {
  final Object? error;

  const ArchiveLocationInsertNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}

