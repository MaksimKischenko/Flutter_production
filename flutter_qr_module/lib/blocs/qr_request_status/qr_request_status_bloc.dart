import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/data/encriptor.dart';
import 'package:fl_qr_module/data/remote_models/common_models/common_models.dart';
import 'package:fl_qr_module/utils/date_helper.dart';
import 'package:fl_qr_module/utils/loger.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';



part 'qr_request_status_event.dart';
part 'qr_request_status_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'qr_request_status_bloc');

class QrRequestStatusBloc
    extends Bloc<QrRequestStatusEvent, QrRequestStatusState> {
  final DataManager dataManager;
  late Timer globalTimer;
  String headerTime = '';
  String statusResponse = '';

  QrRequestStatusBloc({required this.dataManager})
      : super(const QrRequestStatusInitial()) {
    on<QrRequestStatusEvent>(_onEvent);
  }

  Future<void> _onEvent(
    QrRequestStatusEvent event,
    Emitter<QrRequestStatusState> emit,
  ) async {
    if (event is GetRequestStatusRequestRun) {
      await _onGetRequestStatusRun(event, emit);
    }
    if (event is GetRequestStatusRequestDecript) {
      return _onGetRequestStatusDecript(event, emit);
    }
    if (event is GetCheckDuplicate) {
      return _onGetQRCheckDuplicateEvent(event, emit);
    }
  }

  void closeTimer() {
    globalTimer.cancel();
  }

  Future<void> _onGetRequestStatusRun(
    GetRequestStatusRequestRun event,
    Emitter<QrRequestStatusState> emit,
  ) async {
    // emit(QrRequestStatusInProgress());
    try {
      final _secretKeyPart = await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
      if (event.continueStatusCheck) {
        await startStatusTimer(
          event,
          dataManager.nativeHostPayData?.terminalId ?? '',
          dataManager.nativeHostPayData?.typePan ?? '',
          _makeQrPan(dataManager),
          event.requestId,
          continueStatusCheck: event.continueStatusCheck,
          _secretKeyPart ?? '',
        );
      }
    } catch (error, _) {
      emit(QrRequestStatusError(
        error: error,
      ));
    }
  }

  Future<void> _onGetRequestStatusDecript(
    GetRequestStatusRequestDecript event,
    Emitter<QrRequestStatusState> emit,
  ) async{
    final _formedResponse = PsHelpPayQRRequestStatusWrapper.fromJson(
        Map<String, dynamic>.from(
            json.decode(event.decryptedData) as Map<String, dynamic>));

    final _errorCode = _formedResponse.psErip.response.errorCode;
    final _errorText = _formedResponse.psErip.response.errorText;
    final _finalPaymentSum = _formedResponse.psErip.response.finalPaymentSum;
    final bool _showPinWidget;

    if (_finalPaymentSum != null && event.agregatorSumLimit != null) {
      _finalPaymentSum <= event.agregatorSumLimit!
          ? _showPinWidget = false
          : _showPinWidget = true;
    } else {
      _showPinWidget = true;
    }

    final _status = _formedResponse.psErip.response.status;
    final _statusDescriprion =
        _formedResponse.psErip.response.statusDescription;
    _log('decriptedResponse - $_formedResponse');

    void checkStatus(String? statusDescriprion, int status) {
      switch (status) {
        case 0:
          emit(
            QrRequestStatusContinueChecking(
              requestId: event.requestId,
              continueStatusCheck: false,
            ),
          );
          return;
        case 1:
          emit(
            QrRequestStatusSuccess(
              showPinWidget: _showPinWidget,
              requestId: event.requestId,
              continueStatusCheck: false,
            ),
          );
          event.timer.cancel();
          break;
        case 2:
          emit(
            QrRequestStatusPaymentRequestSuccess(
              showPinWidget: _showPinWidget,
              requestId: event.requestId,
              continueStatusCheck: false,
              infoMessage:
                  statusDescriprion ?? 'произведено подтверждение оплаты',
            ),
          );
          event.timer.cancel();

          break;
        case -1:
          emit(QrRequestStatusFail(
            continueStatusCheck: false,
            errorMessage: statusDescriprion ?? 'Платёж сторнирован',
          ));
          event.timer.cancel();

          break;
        case -2:
          emit(
            QrRequestStatusFail(
              continueStatusCheck: false,
              errorMessage:
                  statusDescriprion ?? 'Ошибка обработки запроса Банком',
            ),
          );
          event.timer.cancel();

          break;
        case -3:
          emit(
            QrRequestStatusFail(
              continueStatusCheck: false,
              errorMessage:
                  statusDescriprion ?? 'Истек срок актуальности QR-кода',
            ),
          );
          event.timer.cancel();

          break;
        case -4:
          emit(
            QrRequestStatusFail(
              continueStatusCheck: false,
              errorMessage: statusDescriprion ?? 'Отменена регистрация платежа',
            ),
          );
          event.timer.cancel();

          break;
        case -5:
          emit(
            QrRequestStatusFail(
              continueStatusCheck: false,
              errorMessage:
                  statusDescriprion ?? 'Недостаточно средств для оплаты',
            ),
          );
          event.timer.cancel();

          break;
        default:
          emit(
            QrRequestStatusContinueChecking(
              requestId: event.requestId,
              continueStatusCheck: false,
            ),
          );

          return;
      }
    }

    if (_errorCode == 0) {
      checkStatus(_statusDescriprion, _status);
    } else {
      emit(
        QrRequestStatusErrorKomplat(
          errorCode: _errorCode,
          errorMessage: _errorText ?? '',
        ),
      );
    }
  }

  Future<void> _onGetQRCheckDuplicateEvent(
    GetCheckDuplicate event,
    Emitter<QrRequestStatusState> emit,
  ) async {
    emit(const SuccessStatusCheckDuplicateLoading());
    // emit(QrHistoryLoading());
    try {

      final response = await dataManager.getQRCheckDuplicateRequest(
        terminalID: RegPayMinTerminalID(evalue: dataManager.nativeHostPayData?.terminalId ?? ''),
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        typePan: dataManager.nativeHostPayData?.typePan ?? '',
        pan: _makeQrPan(dataManager),
        requestId: event.requestId, // event.requestId,
        advancedInfoRequired: 0, // must be 0 by default but mb later need event.advancedInfoRequired,
      );

      final _encryptedData = response.data;

      final _secretKeyPart = await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
      final _decryptedData = Criptor().decriptData(
        requestTime: response.response.headers.map['RequestTime']?.first ?? '',
        tempTerminalId: dataManager.nativeHostPayData?.terminalId ?? '',
        secretKeyPart: _secretKeyPart,
        encriptedData: _encryptedData,
      );
      _log('check duplicate response $_decryptedData');

      final _formedResponse =
          PsHelpPayGetQRCheckDuplicateResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.psErip.response.errorCode;
      final _errorText = _formedResponse.psErip.response.errorText;
      final _dateOfPayment = DateFormat('dd/MM/yyyy HH:mm:ss').parse(
          _formedResponse.psErip.response.dateOfPayment ??
              '12/12/2021 12:12:12');
      final output = DateFormat('MM.dd.yyyy hh:mm:ss').format(_dateOfPayment);

      _log('dateTime $output');

      if (_errorCode == 0) {
        emit(
          SuccessStatusCheckDuplicateAccuired(
            requestId: event.requestId,
            dateOfPayment: output,
            receiptNumber: _formedResponse.psErip.response.receiptNumber ?? '',
            receipt: _formedResponse.psErip.response.receipt,
          ),
        );
        // await Future.delayed(
        //   const Duration(milliseconds: 300),
        //   () => emit(
        //     GetQROperationSuccess(
        //       transactionsCount: event.transactionsCount,
        //       qrTransaction: event.qrTransaction,
        //     ),
        //   ),
        // );
      } else {
        emit(
          QrRequestStatusErrorKomplat(
            errorCode: _errorCode,
            errorMessage: _errorText ?? '',
          ),
        );
        // emit(QrHistoryInitial());
      }
    } catch (error, _) {
      emit(QrRequestStatusError(error: error));
    }
  }

  Future<dynamic> startStatusTimer(
    GetRequestStatusRequestRun event,
    String terminalID,
    String typePan,
    QrPan qrPan,
    int requestId,
    String secretKeyPart,
    {required bool continueStatusCheck}
  ) async {
    globalTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (continueStatusCheck && timer.tick < 30) {
          await _getStatus(
            event,
            timer,
            terminalID,
            typePan,
            qrPan,
            requestId,
            continueStatusCheck,
            secretKeyPart,
          );
        } else {
          timer.cancel();
        }
      },
    );
  }


  Future<void> _getStatus(
    GetRequestStatusRequestRun event,
    Timer timer,
    String terminalID,
    String typePan,
    QrPan qrPan,
    int requestId,
    bool continueStatusCheck,
    String secretKeyPart,
  ) async {
    if (continueStatusCheck) {
      // String decryptedData = '';

      final statusResponse = await dataManager.getRequestStatusRequest(
        terminalID: RegPayMinTerminalID(evalue: terminalID),
        version: 1,
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        typePan: typePan, 
        pan: qrPan, //Идентификаторкарты(cardId), либо номер договора счета
        requestId: requestId, //121 correct from BD
      );

      final requestTime = statusResponse
          .response.headers.map['RequestTime']?.first as String;
      final decryptedData = Criptor().decriptData(
        requestTime: requestTime,
        tempTerminalId: terminalID,
        secretKeyPart: secretKeyPart,
        encriptedData: statusResponse.data,
      );

      _log('decryptedData in fetch function $decryptedData');
      add(GetRequestStatusRequestDecript(
        agregatorSumLimit: event.bankSumLimit,
        timer: timer,
        decryptedData: decryptedData,
        requestId: event.requestId,
        continueStatusCheck: event.continueStatusCheck,
      ));
    }
  }

  QrPan _makeQrPan(DataManager dataManager) {
    if (dataManager.nativeHostPayData?.pan == null) {
      throw Exception('Отсутствует карта или номер счёта');
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
}


