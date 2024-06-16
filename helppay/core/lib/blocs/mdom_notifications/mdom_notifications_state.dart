part of 'mdom_notifications_bloc.dart';

abstract class MdomNotificationsState extends Equatable {
  const MdomNotificationsState();

  @override
  List<Object?> get props => [];
}

class MdomNotificationsLoading extends MdomNotificationsState {}

class MdomNotificationsLoaded extends MdomNotificationsState {
  final List<ResponseNotification?> notification;

  const MdomNotificationsLoaded({
    required this.notification,
  });

  @override
  List<Object> get props => [notification];
}

class MdomNotificationsError extends MdomNotificationsState {
  final Object? error;

  const MdomNotificationsError({this.error});

  @override
  List<Object?> get props => [error];
}

class MdomNotificationsErrorKomplat extends MdomNotificationsState {
  final String errorMessage;
  final int errorCode;

  const MdomNotificationsErrorKomplat(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object> get props => [errorMessage, errorCode];
}

class MdomNotificationsToggleRefresh extends MdomNotificationsState {}

class MdomNotificationsLoadedMore extends MdomNotificationsState {
  final List<ResponseNotification> notifications;

  const MdomNotificationsLoadedMore({
    required this.notifications,
  });

  @override
  List<Object> get props => [notifications];
}
