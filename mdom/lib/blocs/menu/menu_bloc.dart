// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/config.dart';
import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuTab? currentTab;

  MenuBloc(): super(MenuState(
    tab: AppConfig.defaultMenuTab
  )) {
    on<MenuEvent>(_onEvent);
  }

  void _onEvent(
    MenuEvent event,
    Emitter<MenuState> emit,
  ) {
    if (event is MenuTabUpdate) return _onMenuTabUpdate(event, emit);
    if (event is MenuHide) return _onMenuHide(event, emit);
    if (event is MenuShow) return _onMenuShow(event, emit);
  }

  void _onMenuTabUpdate(
    MenuTabUpdate event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(
      tab: event.tab
    ));
  }

  void _onMenuHide(
    MenuHide event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(
      isVisible: false
    ));
  }

  void _onMenuShow(
    MenuShow event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(
      isVisible: true
    ));
  }

}
