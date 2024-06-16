part of 'archive_status_bloc.dart';

abstract class ArchiveStatusState extends Equatable {
  const ArchiveStatusState();
  
  @override
  List<Object?> get props => [];
}

class ArchiveStatusLoading extends ArchiveStatusState {}

class ArchiveStatusLoaded extends ArchiveStatusState {
  final List<ArchiveStatus> statuses;

  const ArchiveStatusLoaded({
    required this.statuses,
  });

  @override
  List<Object?> get props => [statuses];
}

class ArchiveStatusError extends ArchiveStatusState {
  final Object? error;

  const ArchiveStatusError({this.error});

  @override
  List<Object?> get props => [error];
}


