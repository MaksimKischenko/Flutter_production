import 'package:equatable/equatable.dart';

class SettingsData extends Equatable {
  final String terminalId;
  final String pan;
  final String typePan;
  final String resourcesUrl;
  final String servletName;
  final int connectionTimeout;
  final int receiveTimeout;
  // таймаут окна ошибки
  final int modalActivityTimeout;
  // таймаут ожидания
  final int waitingTimeout;
  // таймаут мониторинга
  final int monitoringTimeout;

  const SettingsData({
    required this.terminalId,
    required this.pan,
    required this.typePan,
    required this.resourcesUrl,
    required this.servletName,
    required this.connectionTimeout,
    required this.receiveTimeout,
    required this.modalActivityTimeout,
    required this.waitingTimeout,
    required this.monitoringTimeout,
  });

  @override
  List<Object> get props => [
    terminalId,
    pan,
    typePan,
    resourcesUrl,
    servletName,
    connectionTimeout,
    receiveTimeout,
    modalActivityTimeout,
    waitingTimeout,
    monitoringTimeout,
  ];
}
