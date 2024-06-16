part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

class MenuTabUpdate extends MenuEvent {
  final MenuTab? tab;
  final bool? isBnbCardAdd;

  const MenuTabUpdate({this.tab, this.isBnbCardAdd});

  @override
  List<Object?> get props => [tab, isBnbCardAdd];
}

class MenuHide extends MenuEvent {}

class MenuShow extends MenuEvent {}