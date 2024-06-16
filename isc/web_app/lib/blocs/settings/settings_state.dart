// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsInitial extends SettingsState {
  final List<String> claimItems;
  final List<String> paymnetItems;

  const SettingsInitial({
    required this.claimItems,
    required this.paymnetItems,

  });

  @override
  List<Object> get props => [claimItems, paymnetItems];

  SettingsInitial copyWith({
    List<String>? claimItems,
    List<String>? paymnetItems,
  }) => SettingsInitial(
      claimItems: claimItems ?? this.claimItems,
      paymnetItems: paymnetItems ?? this.paymnetItems,
    );
}
