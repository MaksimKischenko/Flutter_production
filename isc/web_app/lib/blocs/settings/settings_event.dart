part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable  {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsInit extends SettingsEvent {}

class SettingsChanged extends SettingsEvent {
  final String? claimItem;
  final String? paymentItem;
  final bool value;

  const SettingsChanged({
    required this.value,
    this.claimItem,
    this.paymentItem,
  });

  @override
  List<Object?> get props => [value,claimItem, paymentItem];
}
