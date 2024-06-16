part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationRun extends RegistrationEvent {
  final RegistrationScreenData data;

  const RegistrationRun({required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'RegistrationRun { data: $data }';
}

class RegistrationParamsEntryCompleted extends RegistrationEvent {
  final List<MdomResponseParam> params;
  final String? sourceOfCommunication;

  const RegistrationParamsEntryCompleted({
    required this.params,
    required this.sourceOfCommunication,
  });

  @override
  List<Object> get props => [params];

  @override
  String toString() => 'RegistrationParamsEntryCompleted { params: $params }';
}

class RegistrationCodeSend extends RegistrationEvent {
  final int code;

  const RegistrationCodeSend({required this.code});

  @override
  List<Object> get props => [code];

  @override
  String toString() => 'RegistrationCodeSend { code: $code }';
}

class RegistrationSetPin extends RegistrationEvent {
  final String pin;

  const RegistrationSetPin({required this.pin});

  @override
  List<Object> get props => [pin];

  @override
  String toString() => 'RegistrationSetPin';
}
