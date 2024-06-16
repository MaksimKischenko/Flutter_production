part of 'mdom_notifications_bloc.dart';

abstract class MdomNotificationsEvent extends Equatable {
  const MdomNotificationsEvent();

  @override
  List<Object> get props => [];
}

class MdomNotificationsInit extends MdomNotificationsEvent {
  final int notificationId;

  const MdomNotificationsInit({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}

class MdomNotificationsCheckLoaded extends MdomNotificationsEvent {}

class MdomNotificationsReadAll extends MdomNotificationsEvent {
  // final int lastNotificationId;

  // const MdomNotificationsReadAll({required this.lastNotificationId});

  // @override
  // List<Object> get props => [lastNotificationId];
}

class MdomNotificationsLoadMore extends MdomNotificationsEvent {
  final int lastNotificationId;
  final int notificationListLength;

  const MdomNotificationsLoadMore( {required this.lastNotificationId, required this.notificationListLength});

  @override
  List<Object> get props => [lastNotificationId];
}
