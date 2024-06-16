part of 'archive_location_bloc.dart';

abstract class ArchiveLocationEvent extends Equatable {
  const ArchiveLocationEvent();

  @override
  List<Object?> get props => [];
}

class ArchiveLocationInit extends ArchiveLocationEvent {}

class NewArchiveLocationUpdateTable extends ArchiveLocationEvent {
  final ArchiveLocation newArchiveLocation;

  const NewArchiveLocationUpdateTable({
    required this.newArchiveLocation,
  });

  @override
  List<Object?> get props => [newArchiveLocation];
}

class EditedArchiveLocationUpdateTable extends ArchiveLocationEvent {
  final ArchiveLocation archiveLocation;

  const EditedArchiveLocationUpdateTable(this.archiveLocation);

  @override
  List<Object?> get props => [archiveLocation];
}

class ArchiveLocationSort extends ArchiveLocationEvent {

  final bool ascending;
  final int sortIndex;

  const ArchiveLocationSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];

}


class ArchiveLocationsDeleteArchiveLocation extends ArchiveLocationEvent {
  final int archiveLocationId;

  const ArchiveLocationsDeleteArchiveLocation(this.archiveLocationId);

  @override
  List<Object?> get props => [archiveLocationId];
}