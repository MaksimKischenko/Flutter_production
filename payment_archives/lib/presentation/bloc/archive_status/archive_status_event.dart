part of 'archive_status_bloc.dart';

abstract class ArchiveStatusEvent extends Equatable {
  const ArchiveStatusEvent();

  @override
  List<Object> get props => [];
}


class ArchiveStatusInit extends ArchiveStatusEvent {}

class ArchiveStatusSort extends ArchiveStatusEvent {

  final bool ascending;
  final int sortIndex;

  const ArchiveStatusSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];
}
