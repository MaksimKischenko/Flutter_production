import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/data/encriptor.dart';
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_core/utils/utils.dart';


part 'cards_issue_event.dart';
part 'cards_issue_state.dart';

class CardsIssueBloc extends Bloc<CardsIssueEvent, CardsIssueState> {
  final DataManager dataManager;

  CardsIssueBloc({
    required this.dataManager,
  }) : super(CardsIssueInitial()) {
    on<CardsIssueEvent>(_onEvent);
  }

  int? _requestId;
  int? _bankId;
  int? _contractKind; 
  String? _phoneNumber; 
  String? _personalNumber;  
  String? _otpCode;  

  void _onEvent(
    CardsIssueEvent event,
    Emitter<CardsIssueState> emit,
  ) {
    if (event is CardIssueInitRun) {
      return _onCardsIssueInitRun(event, emit);
    }
    if (event is CardIssueOTPRun) {
      return _onCardsIssueOTPRun(event, emit);
    }
    if (event is CardIssueIdentifyUserRun) {
      return _onCardsIssueIdentifyUserRun(event, emit);
    }
    if (event is CardsIssue123ConfirmRun) {
      return _onCardsIssue123ConfirmRun(event, emit);
    }
  }



  void _onCardsIssueInitRun(
    CardIssueInitRun event,
    Emitter<CardsIssueState> emit,
  ) async {
     emit(CardsIssueLoading());

      final _terminalId = dataManager.terminalId;
      _bankId = int.tryParse(dataManager.cardBankId ?? ''); 
      _contractKind = int.tryParse(dataManager.cardContractKind ?? ''); 


      //_contractKind = int.tryParse(dataManager.cardParams.copyWith().findByAlias(AliasList.contractKind)?.evalue ?? '');

      final url = dataManager.cardPictureUrl;

      log('$url');

      if(!(event.retryResponse ?? false)) {
        _phoneNumber = event.phoneNumber;
      }
      
      try {
        final response = await dataManager.registerPaymentMethodRequest(
          requestTime: DateTime.now().toStringFormattedQREncrypt(),
          terminalID: RegPayMinTerminalID(evalue: _terminalId),
          version: 1,
          typePan: AliasList.typePanCard,
          cardEmissionParam: CardEmissionParam(
            phoneNumber: _phoneNumber ?? '',
            bankId: _bankId ?? 0,
            contractKind: _contractKind,
          )
        );

        final _encryptedData = response.data;

        final _oldSecretKeyPart = await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);

        final _decryptedData = Criptor().decriptData(
          requestTime: response.response.headers.map['RequestTime']?.first ?? '',
          tempTerminalId: _terminalId,
          secretKeyPart: _oldSecretKeyPart,
          encriptedData: _encryptedData,
        );

        log('DECRYPTDATA- $_decryptedData');


        final _formedResponse =
          PsHelppayRegisterPaymentMethodResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));


       log('formed response TEXT- ${_formedResponse.psHelpPay.response?.errorText}');


        final _errorCode = _formedResponse.psHelpPay.response?.errorCode;
        final _errorText = _formedResponse.psHelpPay.response?.errorText ?? '';
        if (_errorCode == 0) {

          _requestId = _formedResponse.psHelpPay.response?.requestId;
          
          emit(
            const CardsIssueSuccessfulResponse(),
          );

      } else {
          emit(
            CardsIssueErrorKomplat(
              errorCode: _errorCode ?? 404,
              errorMessage: _errorText,
            ),
          );
      }

      } catch(error) {
        emit(CardsIssueNetworkError(error: error));
      }
  }

  void _onCardsIssueOTPRun(
    CardIssueOTPRun event,
    Emitter<CardsIssueState> emit,
  ) async {
     emit(CardsIssueLoading());

      final _terminalId = dataManager.terminalId;
      _otpCode = event.otpCode;
      
      try {

        final response = await dataManager.confirmPaymentMethodRequest(
          requestId: RequestIdentifier(
            evalue: _requestId ?? 0, 
            otpCode: _otpCode, 
            attemptNumber: 1,
            confirmCode: 1
          ),
          requestTime: DateTime.now().toStringFormattedQREncrypt(),
          terminalID: RegPayMinTerminalID(evalue: _terminalId),
          version: 1,
          typePan: AliasList.typePanCard,
        );

        final _encryptedData = response.data;

        final _oldSecretKeyPart = await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);

        final _decryptedData = Criptor().decriptData(
          requestTime: response.response.headers.map['RequestTime']?.first ?? '',
          tempTerminalId: _terminalId,
          secretKeyPart: _oldSecretKeyPart,
          encriptedData: _encryptedData,
        );

        log('DECRYPTDATA- $_decryptedData');


        final _formedResponse =
          PsHelppayConfirmPaymentMethodResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.psHelpPay.response.errorCode;
      final _errorText = _formedResponse.psHelpPay.response.errorText ?? '';

        if (_errorCode == 0) {
          
        emit(const CardsIssueSuccessfulResponse());

      } else {
          emit(
            CardsIssueErrorKomplat(
              errorCode: _errorCode,
              errorMessage: _errorText,
            ),
          );
      }

      } catch(error) {
        emit(CardsIssueNetworkError(error: error));
      }
  }

  void _onCardsIssueIdentifyUserRun(
    CardIssueIdentifyUserRun event,
    Emitter<CardsIssueState> emit,
  ) async {
     emit(CardsIssueLoading());

      final _terminalId = dataManager.terminalId;
      _personalNumber = event.personalNumber;

      try {

        final response = await dataManager.registerPaymentMethodRequest(
          requestTime: DateTime.now().toStringFormattedQREncrypt(),
          terminalID: RegPayMinTerminalID(evalue: _terminalId),
          version: 1,
          typePan: AliasList.typePanCard,
          cardEmissionParam: CardEmissionParam(
            requestId: _requestId.toString(),
            phoneNumber: _phoneNumber ?? '',
            bankId: _bankId ?? 0,
            personalNumber: _personalNumber,
            contractKind: _contractKind,
            attemptNumber: event.attemptNumber
          )
        );

        final _encryptedData = response.data;

        final _oldSecretKeyPart = await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);

        final _decryptedData = Criptor().decriptData(
          requestTime: response.response.headers.map['RequestTime']?.first ?? '',
          tempTerminalId: _terminalId,
          secretKeyPart: _oldSecretKeyPart,
          encriptedData: _encryptedData,
        );

        final _formedResponse =
          PsHelppayRegisterPaymentMethodResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));


       log('formed response TEXT- ${_formedResponse.psHelpPay.response}');


        final _errorCode = _formedResponse.psHelpPay.response?.errorCode;
        final _errorText = _formedResponse.psHelpPay.response?.errorText ?? '';
        if (_errorCode == 0) {

          final _needMSI = _formedResponse.psHelpPay.response?.needMCI == 1;
          final _cards = _formedResponse.psHelpPay.response?.card;
        
          emit(
            CardsIssueSuccessfulResponse(
              needMSI: _needMSI,
              cards: _cards,
            ),
          );
      } else {
          emit(
            CardsIssueErrorKomplat(
              errorCode: _errorCode ?? 404,
              errorMessage: _errorText,
            ),
          );
      }
    } catch(error) {
      emit(CardsIssueNetworkError(error: error));
    }
  }

  void _onCardsIssue123ConfirmRun(
    CardsIssue123ConfirmRun event,
    Emitter<CardsIssueState> emit,
  ) async {
     emit(CardsIssueLoading());

      final _terminalId = dataManager.terminalId;

      // Future.delayed(Duration())
      //   emit(
      //     CardsIssue123ConfirmResponse(
      //       cardId: 95723,
      //       cardPan: '************7895'
      //     ),
      //   ); 
      
      try {

        final response = await dataManager.confirmPaymentMethodRequest(
          requestId: RequestIdentifier(
            evalue: _requestId ?? 0, 
            otpCode: _otpCode, 
            attemptNumber: 1,
            confirmCode: 1,
            cardId: 0,
            contractKind: _contractKind
          ),
          requestTime: DateTime.now().toStringFormattedQREncrypt(),
          terminalID: RegPayMinTerminalID(evalue: _terminalId),
          version: 1,
          typePan: AliasList.typePanCard,
        );

        final _encryptedData = response.data;

        final _oldSecretKeyPart = await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);

        final _decryptedData = Criptor().decriptData(
          requestTime: response.response.headers.map['RequestTime']?.first ?? '',
          tempTerminalId: _terminalId,
          secretKeyPart: _oldSecretKeyPart,
          encriptedData: _encryptedData,
        );

        log('DECRYPTDATA- $_decryptedData');


        final _formedResponse =
          PsHelppayConfirmPaymentMethodResponseWrapper.fromJson(
              Map<String, dynamic>.from(
                  json.decode(_decryptedData) as Map<String, dynamic>));

      final _errorCode = _formedResponse.psHelpPay.response.errorCode;
      final _errorText = _formedResponse.psHelpPay.response.errorText ?? '';

      if (_errorCode == 0) {

        final _cardId = _formedResponse.psHelpPay.response.cardId;
        final _cardPan = _formedResponse.psHelpPay.response.cardPan;
        
        emit(
          CardsIssue123ConfirmResponse(
            cardId: _cardId,
            cardPan: _cardPan
          ),
        );
      } else {
          emit(
            CardsIssueErrorKomplat(
              errorCode: _errorCode,
              errorMessage: _errorText,
            ),
          );
      }

      } catch(error) {
        emit(CardsIssueNetworkError(error: error));
      }
  }
}