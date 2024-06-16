part of 'data_source_insert_bloc.dart';

abstract class DataSourceInsertEvent extends Equatable {
  const DataSourceInsertEvent();

  @override
  List<Object?> get props => [];
}


class DataSourceInsertInit extends DataSourceInsertEvent {}

class DataSourceInsertRun extends DataSourceInsertEvent {
  
  final DataSourceInsertRequest dataSourceInsertBody;

  const DataSourceInsertRun(this.dataSourceInsertBody);

  @override
  List<Object?> get props => [dataSourceInsertBody];
}
