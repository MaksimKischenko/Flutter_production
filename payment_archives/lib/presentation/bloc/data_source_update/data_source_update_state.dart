part of 'data_source_update_bloc.dart';

abstract class DataSourceUpdateState extends Equatable {
  const DataSourceUpdateState();
  
  @override
  List<Object?> get props => [];
}


class DataSourceUpdateInitial extends DataSourceUpdateState {
  final DataSource? dataSource;

  const DataSourceUpdateInitial({
    required this.dataSource,
  });

  @override
  List<Object?> get props => [dataSource];
}


class DataSourceUpdateLoading extends DataSourceUpdateState {}

class DataSourceUpdateSuccess extends DataSourceUpdateState {
  final DataSource? dataSource;

  const DataSourceUpdateSuccess({required this.dataSource});

  @override
  List<Object?> get props => [dataSource];
}


class DataSourceUpdateNetworkError extends DataSourceUpdateState {
  final Object? error;

  const DataSourceUpdateNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}
