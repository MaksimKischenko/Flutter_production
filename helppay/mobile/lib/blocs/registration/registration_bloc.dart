// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_core/models/models.dart';

part 'registration_event.dart';
part 'registration_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'registration_bloc');

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final DataManager dataManager;

  String? _email;
  String? _password;

  RegistrationBloc({required this.dataManager}) : super(RegistrationInitial()) {
    on<RegistrationEvent>(_onEvent);
  }

  void _onEvent(
    RegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) {
    if (event is RegistrationRun) return _onRegistrationRun(event, emit);
    if (event is RegistrationParamsEntryCompleted) {
      return _onRegistrationParamsEntryCompleted(event, emit);
    }
    if (event is RegistrationCodeSend) {
      return _onRegistrationCodeSend(event, emit);
    }
    if (event is RegistrationSetPin) return _onRegistrationSetPin(event, emit);
  }

  void _onRegistrationRun(
    RegistrationRun event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    try {
      final response = await dataManager.createRequest(
        login: event.data.login!, //was email before
        fio: event.data.fio!,
        password: event.data.password!,
        isSendCodeSMS: event.data.isSendCodeSMS!,
        phone: event.data.phone,
      );
      if (response.errorCode.evalue == 0) {
        _email = event.data.email;
        _password = event.data.password;

        dataManager
          ..terminalId = response.token?.terminalId ?? ''
          ..token = response.token?.evalue ?? '';
        final codeType = event.data.isSendCodeSMS!
            ? ConfirmCodeType.sms
            : ConfirmCodeType.email;
        dataManager.codeType = codeType;

        response.params
            ?.changeListParametrByAlias('EMAIL', event.data.email ?? '');

        // lookUps = response.lookups;
        emit(
          RegistrationSuccess(
            params: response.params?.params,
            codeType: codeType,
            lookups: response.lookups?.lookups.first.items,
            phoneNumber: event.data.phone,
          ),
        );
      } else {
        emit(
          RegistrationErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText,
          ),
        );
      }
    } catch (error) {
      emit(RegistrationError(error: error));
    }
    emit(RegistrationInitial());
  }

  void _onRegistrationParamsEntryCompleted(
    RegistrationParamsEntryCompleted event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    final params = MdomRequestParams(
        params: event.params
            .map((e) => MdomRequestParam(
                  name: e.name,
                  id: e.id,
                  idParent: e.idParent,
                  evalue: e.evalue,
                  alias: e.alias,
                ))
            .toList());

    event.params.map((e) => _log('params value - ${e.evalue}'));
    try {
      final response = await dataManager.editUserRequest(userParams: params);
      if (response.errorCode.evalue == 0) {
        emit(RegistrationSuccessEdit(codeType: dataManager.codeType));
      } else {
        emit(RegistrationErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(RegistrationError(error: error));
    }
    emit(RegistrationInitial());
  }

  void _onRegistrationCodeSend(
    RegistrationCodeSend event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    try {
      final response = await dataManager.loginRequest(code: event.code);
      if (response.errorCode.evalue == 0) {
        dataManager
          ..terminalId = response.token?.terminalId ?? ''
          ..token = response.token?.evalue ?? ''
          ..userParams = response.params?.params
          ..lookups = response.lookups?.lookups[0]
          ..userProducts = response.products;

        emit(RegistrationCodeSendSuccess());
      } else {
        emit(RegistrationErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(RegistrationError(error: error));
    }
    emit(RegistrationInitial());
  }

  void _onRegistrationSetPin(
    RegistrationSetPin event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    await SecureStorageManager.write(SecureStorageKeys.pincode, event.pin);
    await SecureStorageManager.write(SecureStorageKeys.login, _email);
    await SecureStorageManager.write(SecureStorageKeys.password, _password);
    dataManager.email = _email;
    _email = null;
    _password = null;
    dataManager.safeViewVisible = false;

    emit(RegistrationPinSetSuccess(
        askForBimetrics: dataManager.isAvailableBiometricAuth,
        komplatBiometricType: dataManager.komplatBiometricType));
    emit(RegistrationInitial());
  }
}
