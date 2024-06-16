import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'data_source_update_event.dart';
part 'data_source_update_state.dart';


class DataSourceUpdateBloc extends Bloc<DataSourceUpdateEvent, DataSourceUpdateState> {

  final DataSourceUseCase useCase;
  int? id;
  DataSource? dataSource;
 
  DataSourceUpdateBloc({
    required this.id,
    required this.dataSource
  }) 
  : useCase = DataSourceUseCase(),
  super(DataSourceUpdateLoading()) {
    log('DATA:$dataSource');
    on<DataSourceUpdateEvent>(_onEvent);
  }


  Future<void>? _onEvent(
    DataSourceUpdateEvent event,
    Emitter<DataSourceUpdateState> emit,
  ) {
    if (event is DataSourceUpdateInit) return _onDataSourceUpdateInit(event, emit);
    if (event is DataSourceUpdateRun) return _onDataSourceUpdateRun(event, emit);
    return null;
  }

  Future<void> _onDataSourceUpdateInit(
    DataSourceUpdateInit event,
    Emitter<DataSourceUpdateState> emit,       
  ) async {

    if (dataSource?.id == 0) {

      final result = await useCase.getInstances(
        id: id
      );

      await result.fold((failure) {
        emit(DataSourceUpdateNetworkError(error: failure.message));
      }, (right) async{
        dataSource = right.data.first;
        id = dataSource?.id;
      });  
    }
    
    emit(DataSourceUpdateInitial(
      dataSource: dataSource,
    ));
  }

  Future<void> _onDataSourceUpdateRun(
    DataSourceUpdateRun event,
    Emitter<DataSourceUpdateState> emit,        
  ) async {

    emit(DataSourceUpdateLoading());

    final result = await useCase.editInstance(
      id: id ?? 0,
      request: event.dataSource
    );

    await result.fold((failure) {
      emit(DataSourceUpdateNetworkError(
        error: failure.message
      ));

      emit(DataSourceUpdateInitial(
        dataSource: dataSource,
      ));
    }, (right) async {
      emit(DataSourceUpdateSuccess(
        dataSource: right.data.first
      ));
    });  
  }
}
