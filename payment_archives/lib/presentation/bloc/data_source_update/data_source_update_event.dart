part of 'data_source_update_bloc.dart';

abstract class DataSourceUpdateEvent extends Equatable {
  const DataSourceUpdateEvent();

  @override
  List<Object?> get props => [];
}


class DataSourceUpdateInit extends DataSourceUpdateEvent {}


class DataSourceUpdateRun extends DataSourceUpdateEvent {
  final DataSourceUpdateRequest dataSource;

  const DataSourceUpdateRun(this.dataSource);

  @override
  List<Object?> get props => [dataSource];
}
