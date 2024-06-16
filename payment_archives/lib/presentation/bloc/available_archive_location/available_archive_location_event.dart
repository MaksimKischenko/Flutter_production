part of 'available_archive_location_bloc.dart';

abstract class AvailableArchiveLocationEvent extends Equatable {
  const AvailableArchiveLocationEvent();

  @override
  List<Object> get props => [];
}

class AvailableArchiveLocationInit extends AvailableArchiveLocationEvent {}

class AvailableArchiveLocationSort extends AvailableArchiveLocationEvent {

  final bool ascending;
  final int sortIndex;

  const AvailableArchiveLocationSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];

}