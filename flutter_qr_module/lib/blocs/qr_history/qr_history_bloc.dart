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
import 'package:retrofit/retrofit.dart';



part 'qr_history_event.dart';
part 'qr_history_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'qr_history_bloc');

class QrHistoryBloc extends Bloc<QrHistoryEvent, QrHistoryState> {
  final DataManager dataManager;

  QrHistoryBloc({required this.dataManager}) : super(QrHistoryInitial()) {
    on<QrHistoryEvent>(_onEvent);
  }

  Future<void> _onEvent(
    QrHistoryEvent event,
    Emitter<QrHistoryState> emit,
  ) async {
    if (event is GetQROperationEvent) {
      return _onGetQROperationEvent(event, emit);
    }
    if (event is GetQRCheckDuplicateEvent) {
      return _onGetQRCheckDuplicateEvent(event, emit);
    }
  }

  Future<void> _onGetQROperationEvent(
    GetQROperationEvent event,
    Emitter<QrHistoryState> emit,
  ) async {
    emit(QrHistoryLoading());
    try {

      final response = await dataManager.getQROperationRequest(
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: dataManager.nativeHostPayData?.terminalId ?? ''),
        typePan: dataManager.nativeHostPayData?.typePan ?? '', 
        pan: _makeQrPan(dataManager),
        requestId: 0,
        filter: OperationFilter(
          dateFrom: event.dateFrom,
          dateTo: event.dateTo,
        ),
      );
      final _decryptedData = await _makeDecription(response, dataManager);
      _log('operations response $_decryptedData');

      final _formedResponse = PsHelpPayQROperationResponseWrapper.fromJson(
          Map<String, dynamic>.from(
              json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.psErip.response.errorCode;
      final _errorText = _formedResponse.psErip.response.errorText;
      final _qrTransactionList =
          _formedResponse.psErip.response.paymentList.qrTransaction;
      final _tranasctionsCount =
          _formedResponse.psErip.response.paymentList.operationsCount;

      if (_errorCode == 0) {
        emit(
          GetQROperationSuccess(
            transactionsCount: _tranasctionsCount,
            qrTransaction: _qrTransactionList?.where((element) => element.status >= 0).toList(),
          ),
        );
      } else {
        emit(
          QrHistoryErrorKomplat(
            errorCode: _errorCode,
            errorMessage: _errorText ?? '',
          ),
        );
        emit(QrHistoryInitial());
      }
    } catch (error, _) {
      emit(QrHistoryError(error: error));
    }
  }

  Future<void> _onGetQRCheckDuplicateEvent(
    GetQRCheckDuplicateEvent event,
    Emitter<QrHistoryState> emit,
  ) async {
    emit(QrHistoryLoading());
    try {

      final response = await dataManager.getQRCheckDuplicateRequest(
        terminalID: RegPayMinTerminalID(evalue: dataManager.nativeHostPayData?.terminalId ?? ''),
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        typePan: dataManager.nativeHostPayData?.typePan ?? '',
        pan: _makeQrPan(dataManager),
        requestId: event.requestId, 
        advancedInfoRequired:0,
      );

      final _decryptedData = await _makeDecription(response, dataManager);
      final _formedResponse =
          PsHelpPayGetQRCheckDuplicateResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.psErip.response.errorCode;
      final _errorText = _formedResponse.psErip.response.errorText;
      final _dateOfPayment = DateFormat('dd/MM/yyyy HH:mm:ss')
          .parse(_formedResponse.psErip.response.dateOfPayment ?? '');
      final output = DateFormat('MM.dd.yyyy hh:mm:ss').format(_dateOfPayment);

      _log('dateTime $output');

      if (_errorCode == 0) {
        emit(
          GetQRCheckDuplicateSuccess(
            dateOfPayment: output,
            receiptNumber: _formedResponse.psErip.response.receiptNumber ?? '',
            receipt: _formedResponse.psErip.response.receipt,
          ),
        );

        await Future.delayed(
          const Duration(milliseconds: 300),
          () => emit(
            GetQROperationSuccess(
              transactionsCount: event.transactionsCount,
              qrTransaction: event.qrTransaction?.where((element) => element.status >= 0).toList(),
            ),
          ),
        );
      } else {
        emit(
          QrHistoryErrorKomplat(
            errorCode: _errorCode,
            errorMessage: _errorText ?? '',
          ),
        );
        emit(QrHistoryInitial());
      }
    } catch (error, _) {
      emit(QrHistoryError(error: error));
    }
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
