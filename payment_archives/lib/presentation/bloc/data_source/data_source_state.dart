part of 'data_source_bloc.dart';

abstract class DataSourceState extends Equatable {
  const DataSourceState();
  
  @override
  List<Object?> get props => [];
}

class DataSourceLoading extends DataSourceState {}

class DataSourceLoaded extends DataSourceState {
  final List<DataSource> dataSources;

  const DataSourceLoaded({
    required this.dataSources,
  });

  @override
  List<Object?> get props => [dataSources];
}

class DataSourcesDeleteDataSourceSuccess extends DataSourceState {
  final int id;

  const DataSourcesDeleteDataSourceSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class DataSourcesAddDataSourceSuccess extends DataSourceState {}

class DataSourcesEditDataSourceSuccess extends DataSourceState {}

class DataSourceError extends DataSourceState {
  final Object? error;

  const DataSourceError({this.error});

  @override
  List<Object?> get props => [error];
}

