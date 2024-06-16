// ignore_for_file: avoid_void_async

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:helppay_core/data/encriptor.dart';
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:helppay_core/data/remote_models/qr_register_payment_response.dart';
import 'package:helppay_core/helppay_core.dart';
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

  void _onEvent(
    QrCamEvent event,
    Emitter<QrCamState> emit,
  ) {
    if (event is QrCamPermissionCheck) {
      return _onQrCamPermissionCheck(event, emit);
    }
    if (event is RegisterQrPayment) {
      return _onRegisterQrPayment(event, emit);
    }
  }

  void _onRegisterQrPayment(
    RegisterQrPayment event,
    Emitter<QrCamState> emit,
  ) async {
    try {
      emit(QrCamRegisterPaymentLoading());
      final _terminalId = dataManager.terminalId;

      final _pan =
          dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;
      final _typePan = dataManager.mainProductType == MainProductType.card
          ? AliasList.typePanCard
          : AliasList.typePanAccount;
      late QrPan qrPan;
      _log('typePan is $_typePan');
      final expiry = dataManager.mainProduct?.params
          .findByAlias(AliasList.expirationDate)
          ?.evalue;
      final redactedExpiry =
          '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
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
        terminalID: RegPayMinTerminalID(evalue: _terminalId),
        typePan: _typePan, // TODO change back to typePAN
        pan: qrPan,
      );

      _log('register payment response ${response.data}');

      final _encryptedData = response.data;

      final _oldSecretKeyPart =
          await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
      final _decryptedData = Criptor().decriptData(
        requestTime: response.response.headers.map['RequestTime']?.first ?? '',
        tempTerminalId: _terminalId,
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

        //TODO Need emit smth
        // final _newSecretKeyPart = _formedResponse.response.secretKey;
        // await SecureStorageManager.write(
        //   SecureStorageKeys.secretKeyPart,
        //   _newSecretKeyPart,
        // );
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
