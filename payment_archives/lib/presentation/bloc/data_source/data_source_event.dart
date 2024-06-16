part of 'data_source_bloc.dart';

abstract class DataSourceEvent extends Equatable {
  const DataSourceEvent();

  @override
  List<Object?> get props => [];
}

class DataSourceInit extends DataSourceEvent {}

class NewDataSourceUpdateTable extends DataSourceEvent {
  final DataSource dataSource;

  const NewDataSourceUpdateTable({
    required this.dataSource,
  });

  @override
  List<Object?> get props => [dataSource];
}

class EditedDataSourceUpdateTable extends DataSourceEvent {
  final DataSource dataSource;

  const EditedDataSourceUpdateTable(this.dataSource);

  @override
  List<Object?> get props => [dataSource];
}

class DataSourceSort extends DataSourceEvent {

  final bool ascending;
  final int sortIndex;

  const DataSourceSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];

}

class DataSourcesDeleteDataSource extends DataSourceEvent {
  final int dataSourceId;

  const DataSourcesDeleteDataSource(this.dataSourceId);

  @override
  List<Object?> get props => [dataSourceId];
}