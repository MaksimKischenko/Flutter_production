import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:helppay_core/data/encriptor.dart';
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:meta/meta.dart';

part 'qr_request_event.dart';
part 'qr_request_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'qr_request_bloc');

class QrRequestBloc extends Bloc<QrRequestEvent, QrRequestState> {
  final DataManager dataManager;

  QrRequestBloc({required this.dataManager}) : super(const QrRequestInitial()) {
    on<QrRequestEvent>(_onEvent);
  }

  void _onEvent(
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

  void _onGetSecretKeyRequestRun(
    GetSecretKeyRequestRun event,
    Emitter<QrRequestState> emit,
  ) async {
    emit(QrRequestLoading());

    try {
      final _terminalId = dataManager.terminalId;
      _log('_terminalId is $_terminalId');

      // final _pan = dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;
      // final _typePan = dataManager.mainProductType == MainProductType.card
      //     ? AliasList.typePanCard
      //     : AliasList.typePanAccount;
      // late QrPan qrPan;
      //_log('typePan is $_typePan');
      // final expiry = dataManager.mainProduct?.params
      //     .findByAlias(AliasList.expirationDate)
      //     ?.evalue;
      // final redactedExpiry =
      //     '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
      // switch (_typePan) {
      //   case 'ACCOUNT':
      //     qrPan = QrPan(expiry: null, value: _pan ?? '');
      //     break;
      //   case 'MS':
      //     qrPan = QrPan(expiry: redactedExpiry, value: _pan ?? '');
      //     break;
      //   default:
      //     qrPan = QrPan(expiry: null, value: _pan ?? '');
      //     break;
      // }
      // _log('typePan is $qrPan');

      final response = await dataManager.getSecretKeyRequest(
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: _terminalId),
        typePan: null, //_typePan, 
        pan: null//qrPan,
      );

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

  void _onGetQrRequestRun(
    GetQrRequestRun event,
    Emitter<QrRequestState> emit,
  ) async {
    emit(QrRequestLoading());

    try {

      final _pan = dataManager.mainProductType == MainProductType.card
          ? dataManager.mainProduct?.params.findByAlias(AliasList.cardId)?.evalue: 
            dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;   

      if (_pan == null) {
        throw Exception(t.exceptions.emtyMainProduct);
      }

      final _typePan = dataManager.mainProductType == MainProductType.card
          ? AliasList.typePanCardForPayment
          : AliasList.typePanAccount;

      final qrPan = QrPan(expiry: null, value: _pan);

      final _terminalId = dataManager.terminalId; // 'MAX2131' from BD;

      _log('main product - ${dataManager.mainProduct?.params}');

      // final expiry = dataManager.mainProduct
      //     ?.params // TODO if we currentlly use 1-2-3 card as main payment mean everything crushes becouse of empty EXPIRY field
      //     // in MdomResponse params be carefull
      //     .findByAlias(AliasList.expirationDate)
      //     ?.evalue;
      // _log('$expiry');
      // final redactedExpiry =
      //     '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
      // switch (_typePan) {
      //   case 'ACCOUNT':
      //     qrPan = QrPan(expiry: null, value: _pan);
      //     break;
      //   case 'MSCI':
      //     qrPan = QrPan(expiry: redactedExpiry, value: _pan);
      //     break;
      //   default:
      //     qrPan = QrPan(expiry: null, value: _pan);
      //     break;
      // }
      final _secretKeyPart =
          await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
      final _requestTimeDebug = DateTime.now().toString().substring(0, 23);
      final _requestTime = DateTime.parse(_requestTimeDebug);
      _log('SECRET KEY- $_secretKeyPart');

      _log('typePan is ${qrPan.value}');
      _log('_terminalId- $_terminalId');
      _log('requestTime: $_requestTime; typePan: ${qrPan.value}; ');
      _log('paymentSum: ${event.paymentSum}');

      final response = await dataManager.getQrRequest(
        requestTime: _requestTime.toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: _terminalId),
        typePan: _typePan, 
        pan: qrPan,
        restSum: 999999,
        paymentSum: event.paymentSum,
      );
      _log('qr response ${response.data}');
      _log('qr response response ${response.response.data}');

      final _encryptedData = response.data;
      final _decryptedData = Criptor().decriptData(
        requestTime: response.response.headers.map['requesttime']?.first ?? '',
        tempTerminalId: _terminalId,
        secretKeyPart: _secretKeyPart,
        encriptedData: _encryptedData,
      );

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

  void _onConfirmQrPaymentRequestRun(
    ConfirmQrPaymentRequestRun event,
    Emitter<QrRequestState> emit,
  ) async {
    emit(QrRequestLoading());
    try {

      final _pan = dataManager.mainProductType == MainProductType.card
          ? dataManager.mainProduct?.params.findByAlias(AliasList.cardId)?.evalue: 
            dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;   

      if (_pan == null) {
        throw Exception(t.exceptions.emtyMainProduct);
      }

      final _typePan = dataManager.mainProductType == MainProductType.card
          ? AliasList.typePanCardForPayment
          : AliasList.typePanAccount;

      final qrPan = QrPan(expiry: null, value: _pan);

      final _terminalId = dataManager.terminalId; // 'MAX2131' from BD;

      _log('typePan is $_typePan');
      _log('PAN is $_pan');

      // final expiry = dataManager.mainProduct?.params
      //     .findByAlias(AliasList.expirationDate)
      //     ?.evalue;

      // final redactedExpiry =
      //     '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
      // switch (typePan) {
      //   case 'ACCOUNT':
      //     qrPan = QrPan(expiry: null, value: pan ?? '');
      //     break;
      //   case 'MS':
      //     qrPan = QrPan(expiry: redactedExpiry, value: pan ?? '');
      //     break;
      //   default:
      //     qrPan = QrPan(expiry: null, value: pan ?? '');
      //     break;
      // }

      final response = await dataManager.confirmQrPaymentRequest(
          requestTime: DateTime.now().toStringFormattedQREncrypt(),
          terminalID: RegPayMinTerminalID(evalue: _terminalId),
          typePan: _typePan, 
          pan: qrPan,
          requestId: event.requestId,
          otpCode: event.code, //was 0 from bd
          confirmCode: 1 //0 или 1
          );

      final _encryptedData = response.data;

      final _secretKeyPart =
          await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);

      final _decryptedData = Criptor().decriptData(
        requestTime: response.response.headers.map['RequestTime']?.first ?? '',
        tempTerminalId: _terminalId,
        secretKeyPart: _secretKeyPart,
        encriptedData: _encryptedData,
      );

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
                    false))); //TODO probably it should be triggered after successful status Check
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

      final _pan = dataManager.mainProductType == MainProductType.card
          ? dataManager.mainProduct?.params.findByAlias(AliasList.cardId)?.evalue: 
            dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;   

      if (_pan == null) {
        throw Exception(t.exceptions.emtyMainProduct);
      }

      final _typePan = dataManager.mainProductType == MainProductType.card
          ? AliasList.typePanCardForPayment
          : AliasList.typePanAccount;

      final qrPan = QrPan(expiry: null, value: _pan);
      final _terminalId = dataManager.terminalId; // 'MAX2131' from BD;


      // final expiry = dataManager.mainProduct?.params
      //     .findByAlias(AliasList.expirationDate)
      //     ?.evalue;
      // final redactedExpiry =
      //     '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
      // switch (typePan) {
      //   case 'ACCOUNT':
      //     qrPan = QrPan(expiry: null, value: pan ?? '');
      //     break;
      //   case 'MS':
      //     qrPan = QrPan(expiry: redactedExpiry, value: pan ?? '');
      //     break;
      //   default:
      //     qrPan = QrPan(expiry: null, value: pan ?? '');
      //     break;
      // }

      _log('typePan is $_typePan');
      _log('PAN is $_pan');


      final response = await dataManager.confirmQrPaymentRequest(
          requestTime: DateTime.now().toStringFormattedQREncrypt(),
          terminalID: RegPayMinTerminalID(evalue: _terminalId),
          typePan: _typePan, 
          pan: qrPan, //Идентификатороплаты.Идентификаторкарты(cardId), либономердоговорасчета
          requestId: event.requestId,
          otpCode:
              event.code.isEmpty ? null : int.parse(event.code), //was 0 from bd
          confirmCode: 0 //0-отмена или 1-подтверждение
          );

      final _encryptedData = response.data;

      final _secretKeyPart =
          await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);

      final _decryptedData = Criptor().decriptData(
        requestTime: response.response.headers.map['RequestTime']?.first ?? '',
        tempTerminalId: _terminalId,
        secretKeyPart: _secretKeyPart,
        encriptedData: _encryptedData,
      );

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
      // requestId: event.requestId,
      isPinFieldVisible: false,
    ));
  }
}
