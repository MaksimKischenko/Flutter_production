part of 'archive_db_bloc.dart';

abstract class ArchiveDbState extends Equatable {
  const ArchiveDbState();
  
  @override
  List<Object?> get props => [];
}

class ArchiveDbLoading extends ArchiveDbState {}

class ArchiveDbLoaded extends ArchiveDbState {
  final List<ArchiveDB> archives;

  const ArchiveDbLoaded({
    required this.archives,
  });

  @override
  List<Object?> get props => [archives];
}

class ArchiveDbError extends ArchiveDbState {
  final Object? error;

  const ArchiveDbError({this.error});

  @override
  List<Object?> get props => [error];
}

