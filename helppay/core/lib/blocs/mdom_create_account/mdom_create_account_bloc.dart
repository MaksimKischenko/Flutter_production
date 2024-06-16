// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';

part 'mdom_create_account_event.dart';
part 'mdom_create_account_state.dart';

class MdomCreateAccountBloc
    extends Bloc<MdomCreateAccountEvent, MdomCreateAccountState> {
  final DataManager dataManager;

  MdomCreateAccountBloc({required this.dataManager})
      : super(MdomCreateAccountLoading()) {
    on<MdomCreateAccountEvent>(_onEvent);
  }

  void _onEvent(
    MdomCreateAccountEvent event,
    Emitter<MdomCreateAccountState> emit,
  ) {
    if (event is MdomCreateAccountInit)
      return _mapMdomCreateAccountInitToState(event, emit);
  }

  void _mapMdomCreateAccountInitToState(
    MdomCreateAccountInit event,
    Emitter<MdomCreateAccountState> emit,
  ) async {
    emit(MdomCreateAccountLoading());

    try {
      final response = await dataManager.accountRegistrationRequest(
          supplierId: event.supplierId,
          account: event.account,
          codeWord: event.codeWord);
      if (response.errorCode?.evalue == 0 && event.codeWord == null) {
        emit(MdomCreateAccountCodeWordSent(
          account: response.account!,
        ));
      } else if (response.errorCode?.evalue == 0) {
        emit(MdomCreateAccountSuccess(
          account: response.account!,
        ));
      } else {
        emit(MdomCreateAccountErrorKomplat(
            errorCode: response.errorCode!.evalue!,
            errorMessage: response.errorCode!.errorText!));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomCreateAccountError(error: error));
    }
  }
}
