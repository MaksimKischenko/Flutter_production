import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/encriptor.dart';
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

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
      late QrPan qrPan;
      final _terminalId = dataManager.terminalId; // 'MAX2131' from BD;
      final pan =
          dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;
      final expiry = dataManager.mainProduct?.params
          .findByAlias(AliasList.expirationDate)
          ?.evalue;
      final redactedExpiry =
          '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
      final typePan = dataManager.mainProductType == MainProductType.card
          ? AliasList.typePanCard
          : AliasList.typePanAccount;
      _log('typePan is $typePan');

      switch (typePan) {
        case 'ACCOUNT':
          qrPan = QrPan(value: pan ?? '');
          break;
        case 'MS':
          qrPan = QrPan(expiry: redactedExpiry, value: pan ?? '');
          break;
        default:
          qrPan = QrPan(value: pan ?? '');
          break;
      }

      final response = await dataManager.getQROperationRequest(
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: _terminalId),
        typePan: typePan, // TODO change back to typePAN
        pan: qrPan,
        // QrPan(
        //   value: 'BY02SLANB2X12000000000000933',
        // ),
        requestId: 0,
        filter: OperationFilter(
          dateFrom: event.dateFrom,
          // "25/01/2023 00:34:09",
          dateTo: event.dateTo,
          // "02/02/2023 18:34:09",
        ),
      );
      _log('date from - ${event.dateFrom}');
      _log('date to - ${event.dateTo}');

      final _encryptedData = response.data;

      final _secretKeyPart =
          await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);

      final _decryptedData = Criptor().decriptData(
        requestTime: response.response.headers.map['RequestTime']?.first ?? '',
        tempTerminalId: _terminalId,
        secretKeyPart: _secretKeyPart,
        encriptedData: _encryptedData,
      );
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
        // TODO QrHistoryScreen?
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

  void _onGetQRCheckDuplicateEvent(
    GetQRCheckDuplicateEvent event,
    Emitter<QrHistoryState> emit,
  ) async {
    emit(QrHistoryLoading());
    try {
      late QrPan qrPan;
      final _terminalId = dataManager.terminalId;
      final pan =
          dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;
      final expiry = dataManager.mainProduct?.params
          .findByAlias(AliasList.expirationDate)
          ?.evalue;
      final redactedExpiry =
          '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';
      final typePan = dataManager.mainProductType == MainProductType.card
          ? AliasList.typePanCard
          : AliasList.typePanAccount;
      _log('typePan is $typePan');

      switch (typePan) {
        case 'ACCOUNT':
          qrPan = QrPan(value: pan ?? '');
          break;
        case 'MS':
          qrPan = QrPan(expiry: redactedExpiry, value: pan ?? '');
          break;
        default:
          qrPan = QrPan(value: pan ?? '');
          break;
      }

      final response = await dataManager.getQRCheckDuplicateRequest(
        terminalID: RegPayMinTerminalID(evalue: _terminalId),
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        typePan: typePan,
        pan: qrPan,
        // QrPan(value: 'BY02SLANB2X12000000000000933') this is from BD
        requestId: event.requestId, // event.requestId,
        advancedInfoRequired:
            0, // must be 0 by default but mb later need event.advancedInfoRequired,
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
      _log('check duplicate response $_decryptedData');

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
