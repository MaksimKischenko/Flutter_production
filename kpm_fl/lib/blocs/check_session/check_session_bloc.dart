// ignore_for_file: avoid_void_async

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';

part 'check_session_event.dart';
part 'check_session_state.dart';

class CheckSessionBloc extends Bloc<CheckSessionEvent, CheckSessionState> {
  final DataManager dataManager;

  Timer? _timer;
  Duration inactiveDuration = const Duration(); 

  CheckSessionBloc({
    required this.dataManager
  }) : super(CheckSessionInitial()) {
    setTimer();
    on<CheckSessionEvent>(_onEvent);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void setTimer() async {
    const checkDuration = Duration(seconds: 5);
    _timer = Timer.periodic(checkDuration, (_) async {
      inactiveDuration = inactiveDuration + checkDuration;
      // print('inactiveDuration: $inactiveDuration');
      final waitingTimeout = (await PreferencesHelper.read(PrefsKeys.waitingTimeout))!;
      final waitingDuration = Duration(seconds: waitingTimeout);
      // final waitingDuration = Duration(seconds: 30);
      if (waitingDuration <= inactiveDuration) {
        inactiveDuration = const Duration();
        add(CheckSessionNeedLogOut());
      }
    });
  }

  void _onEvent(
    CheckSessionEvent event,
    Emitter<CheckSessionState> emit
  ) {
    if (event is CheckSessionUserInteraction) return _onCheckSessionUserInteraction(event, emit);
    if (event is CheckSessionNeedLogOut) return _onCheckSessionNeedLogOut(event, emit);
  }

  void _onCheckSessionUserInteraction(
    CheckSessionUserInteraction event,
    Emitter<CheckSessionState> emit
  ) async {
    inactiveDuration = const Duration();
  }

  void _onCheckSessionNeedLogOut(
    CheckSessionNeedLogOut event,
    Emitter<CheckSessionState> emit
  ) async {
    emit(CheckSessionLoading());
    emit(CheckSessionLogOut());
  }
}
