import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/data/encriptor.dart';
import 'package:fl_qr_module/data/remote_models/common_models/common_models.dart';
import 'package:fl_qr_module/utils/date_helper.dart';
import 'package:fl_qr_module/utils/loger.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/retrofit.dart';

part 'qr_request_event.dart';
part 'qr_request_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'qr_request_bloc');

class QrRequestBloc extends Bloc<QrRequestEvent, QrRequestState> {
  final DataManager dataManager;

  QrRequestBloc({required this.dataManager}) : super(const QrRequestInitial()) {
    on<QrRequestEvent>(_onEvent);
  }

 
  Future<void>? _onEvent(
    QrRequestEvent event,
    Emitter<QrRequestState> emit,
  ) async {
    if (event is GetSecretKeyRequestRun) {
      return _onGetSecretKeyRequestRun(event, emit);
    }
    if (event is EmitInitialState) {
      return _emitInitialState(event, emit);
    }
    if (event is GetQrRequestRun) return _onGetQrRequestRun(event, emit);
    if (event is ConfirmQrPaymentRequestRun) {
      return _onConfirmQrPaymentRequestRun(event, emit);
    }
    if (event is ConfirmQrChangeUiAfterStatusSuccess) {
      return _onConfirmQrChangeUiAfterStatusSuccess(event, emit);
    }
    if (event is CancelQrPaymentRequestRun) {
      await _onCancelQrPaymentRequestRun(event, emit);
    }
  }


  Future<void> _onGetSecretKeyRequestRun(
    GetSecretKeyRequestRun event,
    Emitter<QrRequestState> emit,
  ) async {
    emit(QrRequestLoading());

    try {

      final response = await dataManager.getSecretKeyRequest(
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: dataManager.nativeHostPayData?.terminalId ?? ''),
        typePan: null, //_typePan, 
        pan: null//qrPan,
      );

     final _decryptedData  = await _makeDecription(response, dataManager);
      _log('DECRYPTDATA- $_decryptedData');
      final _formedResponse = PsHelppayGetSecretKeyResponse.fromJson(
          Map<String, dynamic>.from(
              json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.response.errorCode;
      final _errorText = _formedResponse.response.errorText;

      if (_errorCode == 0) {
        final _newSecretKeyPart = _formedResponse.response.secretKey;
        await SecureStorageManager.write(
          SecureStorageKeys.secretKeyPart,
          _newSecretKeyPart,
        );
      } else {
        emit(
          QrRequestErrorKomplat(
            errorCode: _errorCode,
            errorMessage: _errorText ?? '',
          ),
        );
      }
    } catch (error, _) {
      emit(QrRequestError(error: error));
    }
  }


  Future<void> _onGetQrRequestRun(
    GetQrRequestRun event,
    Emitter<QrRequestState> emit,
  ) async {
    emit(QrRequestLoading());

    try {
    
      final _requestTimeDebug = DateTime.now().toString().substring(0, 23);
      final _requestTime = DateTime.parse(_requestTimeDebug);
      final response = await dataManager.getQrRequest(
        requestTime: _requestTime.toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: dataManager.nativeHostPayData?.terminalId ?? ''),
        typePan: dataManager.nativeHostPayData?.typePan ?? '', 
        pan: _makeQrPan(dataManager),
        restSum: 999999,
        paymentSum: event.paymentSum,
      );

      final _decryptedData  = await _makeDecription(response, dataManager);
      _log('decripted data $_decryptedData');
      final _formedResponse = PsHelppayGetQrResponseWrapper.fromJson(
          Map<String, dynamic>.from(
              json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.psErip.response.errorCode;
      final _errorText = _formedResponse.psErip.response.errorText;
      final bankSumLimit = _formedResponse.psErip.response.agregatorSumLimit;

      if (_errorCode == 0) {
        final _qrCode = json.encode(_formedResponse.psErip.response.qrCode);

        final _qrCodeLifetime = _formedResponse.psErip.response.qrCodeLifetime;
        _log('qrCode- $_qrCode');
        _log('lifetime- $_qrCodeLifetime');

        final dynamic _requestId = _formedResponse
            .psErip.response.qrCode!.entries
            .firstWhere((element) => element.key == 'RequestId')
            .value; 

        _log('new request Id- $_requestId');

        emit(QrRequestTriggerStatus(
          bankSumLimit: bankSumLimit,
          requestId: _requestId as int,
        ));
        emit(
          GetQrRequestLoaded(
            bankSumLimit: bankSumLimit,
            isExpired: false,
            isPinFieldVisible: true,
            qrCode: _qrCode.toString(),
            requestId: _requestId,
            qrCodeLifetime: _qrCodeLifetime!,
          ),
        );
      } else {
        emit(
          QrRequestErrorKomplat(
              errorCode: _errorCode, errorMessage: _errorText ?? ''),
        );
        emit(const QrRequestInitial());
      }
    } catch (error, _) {
      emit(QrRequestError(error: error));
      emit(const QrRequestInitial());
    }
  }

  Future<void> _onConfirmQrPaymentRequestRun(
    ConfirmQrPaymentRequestRun event,
    Emitter<QrRequestState> emit,
  ) async {
    emit(QrRequestLoading());
    try {

      final response = await dataManager.confirmQrPaymentRequest(
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: dataManager.nativeHostPayData?.terminalId ?? ''),
        typePan:  dataManager.nativeHostPayData?.typePan ?? '', 
        pan: _makeQrPan(dataManager),
        requestId: event.requestId,
        otpCode: event.code, //was 0 from bd
        confirmCode: 1 //0 или 1
      );

      final _decryptedData  = await _makeDecription(response, dataManager);
      final _formedResponse = PsHelppayConfirmQrPaymentResponseWrapper.fromJson(
          Map<String, dynamic>.from(
              json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.psErip.response.errorCode;
      final _errorText = _formedResponse.psErip.response.errorText;

      if (_errorCode == 0) {
        emit(QrRequestTriggerStatus(
          requestId: event.requestId,
        ));

        await Future.delayed(
            const Duration(seconds: 1),
            () => emit(const QrRequestInitial(
                isPinFieldVisible:
                    false))); 
      } else {
        emit(
          QrRequestErrorKomplat(
            errorCode: _errorCode,
            errorMessage: _errorText ?? '',
          ),
        );
        emit(const QrRequestInitial());
      }
    } catch (error, _) {
      emit(QrRequestError(error: error));
    }
  }

  Future<void> _onCancelQrPaymentRequestRun(
    CancelQrPaymentRequestRun event,
    Emitter<QrRequestState> emit,
  ) async {
    emit(QrRequestLoading());
    try {


      final response = await dataManager.confirmQrPaymentRequest(
          requestTime: DateTime.now().toStringFormattedQREncrypt(),
          terminalID: RegPayMinTerminalID(evalue: dataManager.nativeHostPayData?.terminalId ?? ''),
          typePan: dataManager.nativeHostPayData?.typePan ?? '', 
          pan: _makeQrPan(dataManager), 
          requestId: event.requestId,
          otpCode: event.code.isEmpty ? null : int.parse(event.code), //was 0 from bd
          confirmCode: 0 //0-отмена или 1-подтверждение
          );

      final _decryptedData  = await _makeDecription(response, dataManager);
      final _formedResponse = PsHelppayConfirmQrPaymentResponseWrapper.fromJson(
          Map<String, dynamic>.from(
              json.decode(_decryptedData) as Map<String, dynamic>));
      _log('cancel payment response - $_formedResponse');

      final _errorCode = _formedResponse.psErip.response.errorCode;
      final _errorText = _formedResponse.psErip.response.errorText;

      if (_errorCode == 0) {
        emit(QrRequestCancelSuccessState());
        await Future.delayed(const Duration(seconds: 1),
            () => emit(const QrRequestInitial(isPinFieldVisible: false)));
      } else {
        emit(
          QrRequestErrorKomplat(
            errorCode: _errorCode,
            errorMessage: _errorText ?? '',
          ),
        );
        emit(const QrRequestInitial());
      }
    } catch (error, _) {
      emit(QrRequestError(error: error));
    }
  }

  void _onConfirmQrChangeUiAfterStatusSuccess(
    ConfirmQrChangeUiAfterStatusSuccess event,
    Emitter<QrRequestState> emit,
  ) {
    emit(QrRequestConfirmQrChangeUiAfterStatusSuccess(
      requestId: event.requestId,
      isPinFieldVisible: true,
    ));
  }

  void _emitInitialState(
    EmitInitialState event,
    Emitter<QrRequestState> emit,
  ) {
    emit(const QrRequestInitial(
      isPinFieldVisible: false,
    ));
  }
}

  Future<String> _makeDecription(HttpResponse<String> response, DataManager dataManager) async{
      final _secretKeyPart = await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
      final _encryptedData = response.data;
      return Criptor().decriptData(
        requestTime: response.response.headers.map['RequestTime']?.first ?? '',
        tempTerminalId: dataManager.nativeHostPayData?.terminalId ?? '',
        secretKeyPart: _secretKeyPart,
        encriptedData: _encryptedData,
      );
  }

  QrPan _makeQrPan(DataManager dataManager) {
    if (dataManager.nativeHostPayData?.pan == null) {
      throw Exception('Отсутствует карта или номер счёта ');
    }
    final QrPan qrPan;
    final redactedExpiry = '${dataManager.nativeHostPayData?.expiry?.substring(0, 2)
    }/${dataManager.nativeHostPayData?.expiry?.substring(2, 4)}';

    switch (dataManager.nativeHostPayData?.typePan) {
      case 'ACCOUNT':
        qrPan = QrPan(expiry: null, value: dataManager.nativeHostPayData?.pan ?? '');
        break;
      case 'MS':
        qrPan = QrPan(expiry: redactedExpiry, value: dataManager.nativeHostPayData?.pan ?? '');
        break;
      default:
        qrPan = QrPan(expiry: null, value: dataManager.nativeHostPayData?.pan ?? '');
        break;
    }
    return qrPan;
  }
