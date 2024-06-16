import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';

part 'row_selected_event.dart';
part 'row_selected_state.dart';

class RowSelectedBloc<T> extends Bloc<RowSelectedEvent<T>, RowSelectedState<T>> {

  RowSelectedBloc() : super(RowSelectedState<T>(
    selectedData: SelectedData<T>()
  )) {
    on<RowSelectedEvent<T>>(_onEvent);
  }

  Future<void>? _onEvent(
    RowSelectedEvent<T> event,
    Emitter<RowSelectedState<T>> emit,
  ) {
    if (event is RowSelectedRun<T>) {
      return _onRowSelectedLoad(event, emit);
    }
    return null;
  }

  Future<void> _onRowSelectedLoad(
    RowSelectedRun<T> event,
    Emitter<RowSelectedState<T>> emit,
  ) async{
    emit(state.copyWith(
      selectedData: event.selectedData 
    ));
  }
}

