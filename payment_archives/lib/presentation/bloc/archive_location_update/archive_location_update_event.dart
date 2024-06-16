part of 'archive_location_update_bloc.dart';

abstract class ArchiveLocationUpdateEvent extends Equatable {
  const ArchiveLocationUpdateEvent();

  @override
  List<Object?> get props => [];
}


class ArchiveLocationUpdateInit extends ArchiveLocationUpdateEvent {}


class ArchiveLocationUpdateRun extends ArchiveLocationUpdateEvent {
  final ArchiveLocationUpdateRequest archiveLocation;

  const ArchiveLocationUpdateRun(this.archiveLocation);

  @override
  List<Object?> get props => [archiveLocation];
}
