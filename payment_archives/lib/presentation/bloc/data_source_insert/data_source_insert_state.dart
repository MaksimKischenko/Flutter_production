part of 'data_source_insert_bloc.dart';

abstract class DataSourceInsertState extends Equatable {
  const DataSourceInsertState();
  
  @override
  List<Object?> get props => [];
}

class DataSourceInsertLoading extends DataSourceInsertState {}

class DataSourceInsertInitial extends DataSourceInsertState {}

class DataSourceInsertSuccess extends DataSourceInsertState {
  final DataSource dataSource;

  const DataSourceInsertSuccess({
    required this.dataSource,
  });

  @override
  List<Object?> get props => [dataSource];
}

class DataSourceInsertNetworkError extends DataSourceInsertState {
  final Object? error;

  const DataSourceInsertNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}

