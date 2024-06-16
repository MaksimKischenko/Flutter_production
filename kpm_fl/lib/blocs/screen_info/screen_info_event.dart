part of 'screen_info_bloc.dart';

abstract class ScreenInfoEvent extends Equatable {
  const ScreenInfoEvent();

  @override
  List<Object> get props => [];
}

class ScreenInfoLoad extends ScreenInfoEvent {}