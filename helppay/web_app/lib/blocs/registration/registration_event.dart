part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationRun extends RegistrationEvent {
  final RegistrationScreenData data;

  const RegistrationRun({
    required this.data
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'RegistrationRun { data: $data }';
}

class RegistrationParamsEntryCompleted extends RegistrationEvent {
  final List<MdomResponseParam> params;

  const RegistrationParamsEntryCompleted({
    required this.params
  });

  @override
  List<Object> get props => [params];

  @override
  String toString() => 'RegistrationParamsEntryCompleted { params: $params }';
}


class RegistrationCodeSend extends RegistrationEvent {
  final int code;

  const RegistrationCodeSend({
    required this.code
  });

  @override
  List<Object> get props => [code];

  @override
  String toString() => 'RegistrationCodeSend { code: $code }';
}
