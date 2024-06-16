// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'archive_part_bloc.dart';

abstract class ArchivePartEvent extends Equatable {
  const ArchivePartEvent();

  @override
  List<Object> get props => [];
}


class ArchivePartInit extends ArchivePartEvent {}


class ArchivePartSort extends ArchivePartEvent {

  final bool ascending;
  final int sortIndex;

  const ArchivePartSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];

}

