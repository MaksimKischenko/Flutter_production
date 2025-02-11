

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_qr_module/models/models.dart';


part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuTab? currentTab;

  MenuBloc() : super(const MenuState(tab: MenuTab.paymentQr)) {
    on<MenuEvent>(_onEvent);
  }

  Future<void>? _onEvent(
    MenuEvent event,
    Emitter<MenuState> emit,
  ) {
    if (event is MenuTabUpdate) return _onMenuTabUpdate(event, emit);
    if (event is MenuHide) return _onMenuHide(event, emit);
    if (event is MenuShow) return _onMenuShow(event, emit);
    return null;
  }

  Future<void> _onMenuTabUpdate(
    MenuTabUpdate event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(tab: event.tab));
  }

  Future<void> _onMenuHide(
    MenuHide event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(
      isVisible: false,
    ));
  }

  Future<void> _onMenuShow(
    MenuShow event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(isVisible: true));
  }
}
