part of 'init_helppay_services_bloc.dart';

abstract class InitHelppayServicesEvent extends Equatable {
  const InitHelppayServicesEvent();

  @override
  List<Object?> get props => [];
}

class InitHelppayServicesInit extends InitHelppayServicesEvent {
  final Service? node;
  final int? nodeId;
  final int? nodeType;

  const InitHelppayServicesInit({
    this.node,
    this.nodeId,
    this.nodeType,
  });

  @override
  List<Object?> get props => [node, nodeId];
}
