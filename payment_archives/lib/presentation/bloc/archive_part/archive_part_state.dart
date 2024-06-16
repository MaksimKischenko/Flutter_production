part of 'archive_part_bloc.dart';

abstract class ArchivePartState extends Equatable {
  const ArchivePartState();
  
  @override
  List<Object?> get props => [];
}

class ArchivePartLoading extends ArchivePartState {}

class ArchivePartLoaded extends ArchivePartState {
  final List<ArchiveDBPart> archiveParts;

  const ArchivePartLoaded({
    required this.archiveParts,
  });

  @override
  List<Object?> get props => [archiveParts];  
}

class ArchivePartError extends ArchivePartState {
  final Object? error;

  const ArchivePartError({this.error});

  @override
  List<Object?> get props => [error];
}

