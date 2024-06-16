import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/utils/loger.dart';

part 'return_back_event.dart';
part 'return_back_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'return_back_bloc');

class ReturnBackBloc extends Bloc<ReturnBackEvent, ReturnBackState> {
  ReturnBackBloc() : super(ReturnBackState()) {
    on<ReturnBackEvent>(_onEvent);
  }

  void _onEvent(ReturnBackEvent event, Emitter<ReturnBackState> emit) {
    if (event is ReturnBackInit) return _onReturnBackInit(event, emit);
  }

  void _onReturnBackInit(
      ReturnBackInit event, Emitter<ReturnBackState> emit) async {
    _log('Return back URI - ${event.returnUri}');
    emit(ReturnBackState(
      backUri: event.returnUri,
    ));
  }
}
