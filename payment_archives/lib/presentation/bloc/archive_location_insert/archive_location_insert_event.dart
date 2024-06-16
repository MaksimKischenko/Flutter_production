part of 'archive_location_insert_bloc.dart';

abstract class ArchiveLocationInsertEvent extends Equatable {
  const ArchiveLocationInsertEvent();

  @override
  List<Object?> get props => [];
}


class ArchiveLocationInsertInit extends ArchiveLocationInsertEvent {}

class ArchiveLocationInsertRun extends ArchiveLocationInsertEvent {
  
  final ArchiveLocationInsertRequest archiveLocationInsertBody;

  const ArchiveLocationInsertRun(this.archiveLocationInsertBody);

  @override
  List<Object?> get props => [archiveLocationInsertBody];
}
