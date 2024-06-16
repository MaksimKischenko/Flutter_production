// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'archive_db_bloc.dart';

abstract class ArchiveDbEvent extends Equatable {
  const ArchiveDbEvent();

  @override
  List<Object?> get props => [];
}

class ArchiveDbInit extends ArchiveDbEvent {}

class ArchiveDbSort extends ArchiveDbEvent {

  final bool ascending;
  final int sortIndex;

  const ArchiveDbSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];
}
