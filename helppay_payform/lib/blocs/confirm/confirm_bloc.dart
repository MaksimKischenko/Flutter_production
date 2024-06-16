// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/utils/loger.dart';

part 'confirm_event.dart';
part 'confirm_state.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'conmfirm_bloc');

class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {
  DataManager dataManager;

  ConfirmBloc(this.dataManager) : super(ConfirmInitial()) {
    on<ConfirmEvent>(_onEvent);
  }

  void _onEvent(ConfirmEvent event, Emitter<ConfirmState> emit) {
    if (event is ConfirmRun) {
      return _onConfirmRun(event, emit);
    } else if (event is ResetStateEvent) {
      return _onResetConfirmState(event, emit);
    }
  }

  void _onConfirmRun(ConfirmRun event, Emitter<ConfirmState> emit) async {
    emit(ConfirmLoading());

    try {
      final response = await dataManager.confirmDebetRequest();
      if ((response.errorCode ?? 0) == 0) {
        await PreferencesHelper.clearToken();
        emit(ConfirmSuccess(returnUrl: response.returnUrl));
      } else {
        emit(
          ConfirmErrorKomplat(
            request: RequestType.confirmDebet,
            errorCode: response.errorCode,
            errorText: response.errorText,
            redirectAvailable: true,
          ),
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(ConfirmError(error: error));
    }
    // TODO commented this to prevent errors with check_screen, need to anderstand why its here

    // emit(ConfirmInitial());
  }

  void _onResetConfirmState(
      ResetStateEvent event, Emitter<ConfirmState> emit) async {
    emit(ConfirmInitial());
  }
}
