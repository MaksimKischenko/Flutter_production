enum ProcessingRequestsServerIdStatus {
   empty, jobServer, jobServeDev 
}

extension ProcessingRequestsServerIdStatusExtension on ProcessingRequestsServerIdStatus {
  static const Map<ProcessingRequestsServerIdStatus, String> _names = {
    ProcessingRequestsServerIdStatus.empty: '',
    ProcessingRequestsServerIdStatus.jobServer: 'Сервер заданий',
    ProcessingRequestsServerIdStatus.jobServeDev: 'Сервер заданий- dev only!',

  };

  String get name => _names[this] ?? '';

  static final Map<ProcessingRequestsServerIdStatus, int> _mapToInt = {
    ProcessingRequestsServerIdStatus.empty: -1,
    ProcessingRequestsServerIdStatus.jobServer: 1,
    ProcessingRequestsServerIdStatus.jobServeDev: 2
  };

  int? get ints => _mapToInt[this];

  static final Map<int, ProcessingRequestsServerIdStatus> _fromInt = {
   -1: ProcessingRequestsServerIdStatus.empty,
    1: ProcessingRequestsServerIdStatus.jobServer,
    2: ProcessingRequestsServerIdStatus.jobServeDev
  };

  static ProcessingRequestsServerIdStatus fromInt(int? value) => _fromInt[value] ?? ProcessingRequestsServerIdStatus.empty;

}