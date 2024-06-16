// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';

part 'registration_event.dart';
part 'registration_state.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'web_registration_bloc');

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final DataManager dataManager;

  String? email;
  String? password;

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
  }

  void _onRegistrationRun(
    RegistrationRun event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    try {
      final response = await dataManager.createRequest(
        login: event.data.login!,
        fio: event.data.fio!,
        password: event.data.password!,
        isSendCodeSMS: event.data.isSendCodeSMS!,
        phone: event.data.phone,
      );
      if (response.errorCode.evalue == 0) {
        email = event.data.email;
        password = event.data.password;

        dataManager
          ..terminalId = response.token?.terminalId ?? ''
          ..token = response.token?.evalue ?? '';
        final codeType = event.data.isSendCodeSMS!
            ? ConfirmCodeType.sms
            : ConfirmCodeType.email;
        dataManager.codeType = codeType;

        response.params
            ?.changeListParametrByAlias('EMAIL', event.data.email ?? '');

        emit(
          RegistrationSuccess(
            params: response.params?.params,
            codeType: codeType,
            lookups: response.lookups?.lookups.first.items,
            phoneNumber: event.data.phone,
          ),
        );
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
    // event.params.map((e) => _log('params value - ${e.evalue}'));

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
}
