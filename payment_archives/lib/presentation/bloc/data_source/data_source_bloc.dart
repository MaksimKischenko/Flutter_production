import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'data_source_event.dart';
part 'data_source_state.dart';


class DataSourceBloc extends Bloc<DataSourceEvent, DataSourceState> {

  final DataSourceUseCase useCase;
  
  DataSourceBloc()
  : useCase = DataSourceUseCase(),
  super(DataSourceLoading()) {
    on<DataSourceEvent>(_onEvent);
  }

  late List<DataSource> _dataSources;

  Future<void>? _onEvent(
    DataSourceEvent event,
    Emitter<DataSourceState> emit,
  ) {
    if (event is DataSourceInit) return _onDataSourceInit(event, emit);
    if (event is NewDataSourceUpdateTable) return _onNewDataSource(event, emit);
    if (event is EditedDataSourceUpdateTable) return _onUpdateDataSource(event, emit);
    if (event is DataSourcesDeleteDataSource) return _onDeleteDataSource(event, emit);    
    if (event is DataSourceSort) return _onSortDataSource(event, emit);
    return null;        
  }

  Future<void> _onDataSourceInit(
    DataSourceInit event,
    Emitter<DataSourceState> emit,
  ) async {

    final result = await useCase.getInstances();

    await result.fold((failure) {
      emit(DataSourceError(error: failure.message));
    }, (right) async{
      _dataSources = right.data;
      emit(DataSourceLoaded(
        dataSources: _dataSources
      ));
    });       
  }


  Future<void> _onNewDataSource(
    NewDataSourceUpdateTable event,
    Emitter<DataSourceState> emit,
  ) async {

    emit(DataSourceLoading());
    
    _dataSources.insert(0, event.dataSource);

    emit(DataSourcesAddDataSourceSuccess());
    
    emit(DataSourceLoaded(
      dataSources: _dataSources
    ));
  }

  Future<void> _onUpdateDataSource(
    EditedDataSourceUpdateTable event,
    Emitter<DataSourceState> emit,
  ) async {

    emit(DataSourceLoading());
    
    final index = _dataSources.indexWhere((e) => e.id == event.dataSource.id);
      if (index > -1) {
        _dataSources[index] = event.dataSource;
      }

    emit(DataSourcesEditDataSourceSuccess());
    
    emit(DataSourceLoaded(
      dataSources: _dataSources
    ));
  }

  Future<void> _onDeleteDataSource(
    DataSourcesDeleteDataSource event,
    Emitter<DataSourceState> emit,
  ) async {

    emit(DataSourceLoading());

    final result = await useCase.deleteInstance(
      id: event.dataSourceId
    );

    await result.fold((failure) {
      emit(DataSourceError(error: failure.message));     
    }, (right) async{
      _dataSources.removeWhere((e) => e.id == event.dataSourceId); 
      emit(DataSourcesDeleteDataSourceSuccess(
        event.dataSourceId
      ));
      emit(DataSourceLoaded(
        dataSources: _dataSources
      ));      
    }); 
  }  


  Future<void> _onSortDataSource(
    DataSourceSort event,
    Emitter<DataSourceState> emit,   
  ) async {

    emit(DataSourceLoading());

    useCase.sortValues(
      dataSources: _dataSources,
      ascending: event.ascending,
      sortIndex: event.sortIndex
    );

    emit(DataSourceLoaded(
      dataSources: _dataSources
    ));
  }
}
