// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final DataManager dataManager;

  late String _email;
  late String _password;

  RegistrationBloc({
    required this.dataManager,
  }) : super(RegistrationInitial()) {
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
    if (event is RegistrationBiometricResponse) {
      return _onRegistrationBiometricResponse(event, emit);
    }
  }

  void _onRegistrationRun(
    RegistrationRun event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    try {
      final response = await dataManager.createRequest(
        login: event.data.email!,
        password: event.data.password!,
        fio: event.data.fio!,
        isSendCodeSMS: event.data.isSendCodeSMS!,
        phone: event.data.phone,
        keyRegistration: event.data.keyRegistration,
      );
      if (response.errorCode.evalue == 0) {
        _email = event.data.email!;
        _password = event.data.password!;

        final codeType = event.data.isSendCodeSMS!
            ? ConfirmCodeType.sms
            : ConfirmCodeType.email;

        dataManager
          ..terminanlId = response.token?.terminalId ?? '' //Shity fixes
          ..token = response.token?.evalue ?? ''
          ..codeType = codeType;

        emit(
          RegistrationSuccess(
              params: response.params?.params, codeType: codeType),
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
            .map(
              (e) => MdomRequestParam(
                name: e.name,
                id: e.id,
                idParent: e.idParent,
                evalue: e.evalue,
                alias: e.alias,
              ),
            )
            .toList());

    try {
      final response = await dataManager.editUserRequest(userParams: params);
      if (response.errorCode.evalue == 0) {
        emit(RegistrationSuccessEdit(codeType: dataManager.codeType));
      } else {
        emit(
          RegistrationErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText,
          ),
        );
      }
    } catch (error, stacktrace) {
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
          ..terminanlId = response.token!.terminalId!
          ..userParams = response.params?.params;
        // TODO: receive empty
        // _dataManager.token = response.token.evalue;

        await dataManager.loadServicesList();
        await dataManager.informationRequest();

        emit(RegistrationCodeSendSuccess());
      } else {
        emit(
          RegistrationErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText,
          ),
        );
      }
    } catch (error, stacktrace) {
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
    dataManager
      ..email = _email
      ..safeViewVisible = false;
    // _email = null;
    // _password = null;

    const bioTypeMap = <KomplatBiometricType, String>{
      KomplatBiometricType.faceid: 'Face ID',
      KomplatBiometricType.touchid: 'Touch ID',
      KomplatBiometricType.biometric: 'биометрию'
    };

    if (dataManager.isAvailableBiometricAuth) {
      emit(
        RegistrationAskForBiometrics(
          biometricDescription: bioTypeMap[dataManager.komplatBiometricType]!,
        ),
      );
    } else {
      emit(RegistrationPinSetSuccess());
    }

    emit(RegistrationInitial());
  }

  void _onRegistrationBiometricResponse(
    RegistrationBiometricResponse event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    if (event.response) {
      await PreferencesHelper.write(PrefsKeys.authWithBiometric, true);
      dataManager.authWithBiometricsFlag = true;
    }
    dataManager.safeViewVisible = false;
    emit(RegistrationPinSetSuccess());

    emit(RegistrationInitial());
  }
}
