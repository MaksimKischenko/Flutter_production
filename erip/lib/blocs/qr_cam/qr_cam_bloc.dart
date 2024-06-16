import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'qr_cam_event.dart';
part 'qr_cam_state.dart';

class QrCamBloc extends Bloc<QrCamEvent, QrCamState> {
  QrCamBloc() : super(QrCamLoading());

  @override
  Stream<QrCamState> mapEventToState(
    QrCamEvent event,
  ) async* {
    if (event is QrCamPermissionCheck) {
      yield* _checkPermission();
    }
    if (event is QrCamToggleFlash) {
      if (state is QrCamPemissionGranted) {
        final st = state as QrCamPemissionGranted;
        yield QrCamPemissionGranted(currentFlash: !st.currentFlash);
      }
    }
    if (event is QrCamDisableFlash) {
      if (state is QrCamPemissionGranted) {
        yield const QrCamPemissionGranted(currentFlash: false);
      }
    }
  }

  Stream<QrCamState> _checkPermission() async* {
    yield QrCamLoading();
    final status = await Permission.camera.status;
    if (status.isDenied) {
      final requestStatus = await Permission.camera.request();
      yield* _mapPermissionStatusToState(requestStatus);
    } else {
      yield* _mapPermissionStatusToState(status);
    }
    
  }

  Stream<QrCamState> _mapPermissionStatusToState(PermissionStatus status) async* {
    if (status.isGranted) {
      yield const QrCamPemissionGranted(currentFlash: false);
    }
    if (status.isDenied) {
      yield QrCamPemissionDenied();
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      yield QrCamPemissionPermamentlyDenied();
    }
  }
}
