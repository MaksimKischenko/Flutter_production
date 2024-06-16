// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';

part 'mdom_accruals_event.dart';
part 'mdom_accruals_state.dart';

class MdomAccrualsBloc extends Bloc<MdomAccrualsEvent, MdomAccrualsState> {
  final DataManager dataManager;

  MdomAccrualsBloc({
    required this.dataManager,
  }): super(MdomAccrualsLoading()) {
    on<MdomAccrualsEvent>(_onEvent);
  }

  bool _firstLoaded = false;

  void _onEvent(
    MdomAccrualsEvent event,
    Emitter<MdomAccrualsState> emit,
  ) {
    if (event is MdomAccrualsInit) return  _onMdomAccrualsInit(event, emit);
    if (event is MdomAccrualsCheckLoaded) return _onMdomAccrualsCheckLoaded(event, emit);
    if (event is MdomAccrualsNewAccount) return _onMdomAccrualsNewAccount(event, emit);
  }

  void _onMdomAccrualsInit(
    MdomAccrualsInit event,
    Emitter<MdomAccrualsState> emit,
  ) async {
    emit(MdomAccrualsLoading());

    try {
      final response = await dataManager.companiesRequest();
      if (response.errorCode?.evalue == 0) {      
        emit(MdomAccrualsLoaded(
          companies: response.companies ?? []
        ));
        _firstLoaded = true;
      } else {
        emit(MdomAccrualsErrorKomplat(
          errorCode: response.errorCode!.evalue!,
          errorMessage: response.errorCode!.errorText!
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomAccrualsError(
        error: error
      ));
    }
  }

  void _onMdomAccrualsCheckLoaded(
    MdomAccrualsCheckLoaded event,
    Emitter<MdomAccrualsState> emit,
  ) async {
    if (!_firstLoaded) {
      emit(MdomAccrualsToggleRefresh());
    } else {
      if (state is MdomAccrualsLoaded) {
        final tempState = state;
        emit(MdomAccrualsLoading());
        emit(tempState);
      }
    }
  }

  void _onMdomAccrualsNewAccount(
    MdomAccrualsNewAccount event,
    Emitter<MdomAccrualsState> emit,
  ) async {
    emit(MdomAccrualsToggleRefresh());
  }
}
