// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

part 'qr_cam_event.dart';
part 'qr_cam_state.dart';

class QrCamBloc extends Bloc<QrCamEvent, QrCamState> {
  QrCamBloc() : super(QrCamLoading()) {
    on<QrCamEvent>(_onEvent);
  }

  void _onEvent(
    QrCamEvent event,
    Emitter<QrCamState> emit,
  ) {
    if (event is QrCamPermissionCheck) return _onQrCamPermissionCheck(event, emit);
  }

  void _onQrCamPermissionCheck(
    QrCamPermissionCheck event,
    Emitter<QrCamState> emit,
  ) async {
    emit(QrCamLoading());
    final status = kIsWeb
        ? PermissionStatus.permanentlyDenied
        : await Permission.camera.status;
    if (status.isDenied) {
      final requestStatus = await Permission.camera.request();
      emit(_mapPermissionStatusToState(requestStatus));
    } else {
      emit(_mapPermissionStatusToState(status));
    }
    
  }

  QrCamState _mapPermissionStatusToState(PermissionStatus status) {
    if (status.isGranted) {
      return QrCamPermissionGranted();
    } else if (status.isDenied) {
      return QrCamPermissionDenied();
    } else if (status.isPermanentlyDenied || status.isRestricted) {
      return QrCamPermissionPermamentlyDenied();
    } else {
      return QrCamPermissionDenied();
    }
  }
}
