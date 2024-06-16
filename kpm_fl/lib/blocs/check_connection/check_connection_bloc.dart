// ignore_for_file: avoid_void_async

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';

part 'check_connection_event.dart';
part 'check_connection_state.dart';

class CheckConnectionBloc extends Bloc<CheckConnectionEvent, CheckConnectionState> {
  final DataManager dataManager;

  Timer? _timer;

  CheckConnectionBloc({
    required this.dataManager
  }) : super(CheckConnectionLoading()) {
    setNewTimer();
    on<CheckConnectionEvent>(_onEvent);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void setNewTimer() async {
    final monitoringTimeout = (await PreferencesHelper.read(PrefsKeys.monitoringTimeout))!;

    _timer = Timer.periodic(Duration(seconds: monitoringTimeout), (_) {
      add(CheckConnectionInit());
      _timer?.cancel();
      setNewTimer();
    });
  }

  String? ipAddress;

  void _onEvent(
    CheckConnectionEvent event,
    Emitter<CheckConnectionState> emit
  ) {
    if (event is CheckConnectionInit) return _onCheckConnectionInit(event, emit);
  }

  void _onCheckConnectionInit(
    CheckConnectionInit event,
    Emitter<CheckConnectionState> emit
  ) async {
    emit(CheckConnectionLoading());

    try {
      ipAddress ??= await dataManager.getIpAddress();
      
      final response = await dataManager.checkConnectRequest(
        ipAddress: ipAddress!,
      );
      if ((response.errorCode ?? 0) == 0) {
        emit(CheckConnectionSuccess());
      } else {
        emit(CheckConnectionErrorKomplat(
          request: RequestType.checkConnection,
          errorCode: response.errorCode,
          errorText: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(CheckConnectionError(error: error));
    }
  }
}
