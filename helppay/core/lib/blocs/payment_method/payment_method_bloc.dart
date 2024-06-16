// ignore_for_file: avoid_void_async

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/data/encriptor.dart';
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_core/utils/utils.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'products_bloc');

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final DataManager dataManager;

  PaymentMethodBloc({
    required this.dataManager,
  }) : super(RegisterPaymentMethodLoading()) {
    on<PaymentMethodEvent>(_onEvent);
  }

  void _onEvent(
    PaymentMethodEvent event,
    Emitter<PaymentMethodState> emit,
  ) {
    if (event is RegisterPaymentMethod) {
      return _onProductsRegisterPaymentMethod(event, emit);
    }
    if (event is ConfirmPaymentMethod) {
      return _onProductsConfirmPaymentMethod(event, emit);
    }
  }

  void _onProductsRegisterPaymentMethod(
    RegisterPaymentMethod event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(RegisterPaymentMethodLoading());
    final listOfPans = event.accountsList
        .map((e) => e.params.params.where((element) => element.alias == 'PAN'))
        .toList();
    _log('List of Pans- $listOfPans');
    final _terminalId = dataManager.terminalId;

    final _pan = event.paymentMethodData
        .where((element) => element.alias == 'PAN')
        .first
        .evalue;
    _log('current pan $_pan');
    final _typePan = event.typePan;
    late QrPan qrPan;
    _log('typePan is $_typePan');
    //TODO
    // final expiry = dataManager.mainProduct?.params
    //     .findByAlias(AliasList.expirationDate)
    //     ?.evalue;
    // final redactedExpiry =
    //     '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';

    switch (_typePan) {
      case 'ACCOUNT':
        qrPan = QrPan(expiry: null, value: _pan ?? '');
        break;
      case 'MS':
        qrPan = QrPan(expiry: null, value: _pan ?? '');
        break;
      default:
        qrPan = QrPan(expiry: null, value: _pan ?? '');
        break;
    }
    try {
      final response = await dataManager.registerPaymentMethodRequest(
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: _terminalId),
        version: 1,
        typePan: _typePan,
        pan: qrPan,
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

      final _formedResponse =
          PsHelppayRegisterPaymentMethodResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));

      _log('formed response- $_formedResponse');

      final _errorCode = _formedResponse.psHelpPay.response?.errorCode;
      final _errorText = _formedResponse.psHelpPay.response?.errorText ?? '';

      if (_errorCode == 0) {
        emit(
          RegisterPaymentMethodSuccess(
            requestId: _formedResponse.psHelpPay.response?.requestId ?? 0,
            paymentMethodData: event.paymentMethodData,
            typePan: _typePan,
          ),
        );
      } else {
        emit(
          RegisterPaymentMethodKomplat(
            needPop: true,
            errorCode: _errorCode ?? 404,
            errorMessage: _errorText,
          ),
        );
      }
    } catch (error) {
      emit(RegisterPaymetnMethodError(error: error));
    }
  }

  void _onProductsConfirmPaymentMethod(
    ConfirmPaymentMethod event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(RegisterPaymentMethodLoading());

    final _terminalId = dataManager.terminalId;

    final _pan =
        dataManager.mainProduct?.params.findByAlias(AliasList.number)?.evalue;
    final _typePan = event
        .typePan; // TODO this typePAN is mistaken becouse main product can be MS but there we should send Account need refactor as in RegisterPayment method
    late QrPan qrPan;
    _log('typePan is $_typePan');
    // final expiry = dataManager.mainProduct?.params
    //     .findByAlias(AliasList.expirationDate)
    //     ?.evalue;
    // final redactedExpiry =
    //     '${expiry?.substring(0, 2)}/${expiry?.substring(2, 4)}';

    switch (_typePan) {
      case 'ACCOUNT':
        qrPan = QrPan(expiry: null, value: _pan ?? '');
        break;
      case 'MS':
        qrPan = QrPan(expiry: null, value: _pan ?? '');
        break;
      default:
        qrPan = QrPan(expiry: null, value: _pan ?? '');
        break;
    }
    try {
      final response = await dataManager.confirmPaymentMethodRequest(
        requestTime: DateTime.now().toStringFormattedQREncrypt(),
        terminalID: RegPayMinTerminalID(evalue: _terminalId),
        version: 1,
        typePan: _typePan,
        pan: qrPan,
        requestId: event.requestIdentifier,
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

      final _formedResponse =
          PsHelppayConfirmPaymentMethodResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));

      _log('formed response- $_formedResponse');

      final _errorCode = _formedResponse.psHelpPay.response.errorCode;
      final _errorText = _formedResponse.psHelpPay.response.errorText ?? '';

      if (_errorCode == 0) {
        emit(
          ConfirmPaymentMethodSuccess(
            // requestId: _formedResponse.psHelpPay.response.requestId,
            paymentMethodData: event.paymentMethodData,
          ),
        );
      } else {
        emit(
          RegisterPaymentMethodKomplat(
            errorCode: _errorCode,
            errorMessage: _errorText,
          ),
        );
      }
    } catch (error) {
      emit(RegisterPaymetnMethodError(error: error));
    }
  }
}
