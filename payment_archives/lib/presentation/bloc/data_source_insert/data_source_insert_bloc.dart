import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'data_source_insert_event.dart';
part 'data_source_insert_state.dart';


class DataSourceInsertBloc extends Bloc<DataSourceInsertEvent, DataSourceInsertState> {

  final DataSourceUseCase useCase;

  DataSourceInsertBloc()
  : useCase = DataSourceUseCase(),
  super(DataSourceInsertLoading()) {
    on<DataSourceInsertEvent>(_onEvent);
  }

  Future<void>? _onEvent(
    DataSourceInsertEvent event,
    Emitter<DataSourceInsertState> emit,
  ) {
    if (event is DataSourceInsertInit) return _onDataSourceInsertInit(event, emit);
    if (event is DataSourceInsertRun) return _onDataSourceInsertRun(event, emit);
    return null;
  }

  Future<void> _onDataSourceInsertInit(
    DataSourceInsertInit event,
    Emitter<DataSourceInsertState> emit,       
  ) async {

    emit(DataSourceInsertInitial());
  }

  Future<void> _onDataSourceInsertRun(
    DataSourceInsertRun event,
    Emitter<DataSourceInsertState> emit,        
  ) async {

    emit(DataSourceInsertLoading());

    final result = await useCase.saveInstance(event.dataSourceInsertBody);

    await result.fold((failure) {
      emit(DataSourceInsertNetworkError(
        error: failure.message
      ));
      emit(DataSourceInsertInitial());
    }, (right) async {
      emit(DataSourceInsertSuccess(
        dataSource: right.data.first
      ));
    });   
  }
}
