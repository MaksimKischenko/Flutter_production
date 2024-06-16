

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/data/encriptor.dart';
import 'package:fl_qr_module/data/remote_models/common_models/common_models.dart';
import 'package:fl_qr_module/data/remote_models/qr_register_payment_response.dart';
import 'package:fl_qr_module/utils/date_helper.dart';
import 'package:fl_qr_module/utils/loger.dart';

import 'package:permission_handler/permission_handler.dart';



part 'qr_cam_event.dart';
part 'qr_cam_state.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'qr_cam_bloc');

class QrCamBloc extends Bloc<QrCamEvent, QrCamState> {
  final DataManager dataManager;
  QrCamBloc({
    required this.dataManager,
  }) : super(QrCamLoading()) {
    on<QrCamEvent>(_onEvent);
  }

  Future<void>? _onEvent(
    QrCamEvent event,
    Emitter<QrCamState> emit,
  ) {
    if (event is QrCamPermissionCheck) {
      return _onQrCamPermissionCheck(event, emit);
    }
    if (event is RegisterQrPayment) {
      return _onRegisterQrPayment(event, emit);
    }
    return null;
  }

  Future<void> _onRegisterQrPayment(
    RegisterQrPayment event,
    Emitter<QrCamState> emit,
  ) async {
    try {
      emit(QrCamRegisterPaymentLoading());
      final _terminalId = dataManager.nativeHostPayData?.terminalId;
      final _pan = dataManager.nativeHostPayData?.pan;
      final _typePan = dataManager.nativeHostPayData?.typePan;
      late QrPan qrPan;
      final expiry = dataManager.nativeHostPayData?.expiry;
      final redactedExpiry ='${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
      switch (_typePan) {
        case 'ACCOUNT':
          qrPan = QrPan(expiry: null, value: _pan ?? '');
          break;
        case 'MS':
          qrPan = QrPan(expiry: redactedExpiry, value: _pan ?? '');
          break;
        default:
          qrPan = QrPan(expiry: null, value: _pan ?? '');
          break;
      }

      final response = await dataManager.registerPaymentRequest(
        requestId: event.requestId,
        version: 1,
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: _terminalId ?? ''),
        typePan: _typePan ?? '', 
        pan: qrPan,
      );

      final _encryptedData = response.data;
      final _oldSecretKeyPart =  await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
      final _decryptedData = Criptor().decriptData(
        requestTime: response.response.headers.map['RequestTime']?.first ?? '',
        tempTerminalId: _terminalId ?? '',
        secretKeyPart: _oldSecretKeyPart,
        encriptedData: _encryptedData,
      );

      _log('DECRYPTDATA- $_decryptedData');

      final _formedResponse =
          PsHelppayQrRegisterPaymentResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));

      _log('formed response- $_formedResponse');

      final _errorCode = _formedResponse.psHelpPay.response.errorCode;
      final _errorText = _formedResponse.psHelpPay.response.errorText ?? '';

      if (_errorCode == 0) {
        emit(const QrCamRegisterPaymentSuccess(needPop: true));
        await Future<void>.delayed(
          const Duration(),
          () => emit(const QrCamPermissionGranted()),
        );

      } else {
        emit(
          QrCamErrorKomplat(
            needPop: true,
            errorCode: _errorCode,
            errorMessage: _errorText,
          ),
        );
      }
    } catch (error, _) {
      emit(QrCamError(
        error: error,
        needPop: true,
      ));
    }
  }

  Future<void> _onQrCamPermissionCheck(
    QrCamPermissionCheck event,
    Emitter<QrCamState> emit,
  ) async {
    emit(QrCamLoading());
    final status = await Permission.camera.status;
    if (status.isDenied) {
      final requestStatus = await Permission.camera.request();
      emit(_mapPermissionStatusToState(requestStatus));
    } else {
      emit(_mapPermissionStatusToState(status));
    }
  }

  QrCamState _mapPermissionStatusToState(PermissionStatus status) {
    if (status.isGranted) {
      return const QrCamPermissionGranted();
    } else if (status.isDenied) {
      return QrCamPermissionDenied();
    } else if (status.isPermanentlyDenied || status.isRestricted) {
      return QrCamPermissionPermamentlyDenied();
    } else {
      return QrCamPermissionDenied();
    }
  }
}
