import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';


class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {


  SettingsBloc(): super(SettingsLoading()) {
    on<SettingsEvent>(_onEvent);
  }
  
  void _onEvent(
    SettingsEvent event,
    Emitter<SettingsState> emit
  ) {
    if (event is SettingsInit) return _mapSettingsInitToState(event, emit);
    if (event is SettingsChanged) return _mapSettingsChangedToState(event, emit);
  }

  List<String>? claimItems = [];
  List<String>? paymentItems = [];

  void _mapSettingsInitToState(
    SettingsInit event, 
    Emitter<SettingsState> emit) async {

    emit(SettingsLoading());

     claimItems = await PreferencesHelper.read(PrefsKeys.claimItems) ?? ClaimsTableColumns.values.map((e) => e.columnName).toList();
     paymentItems = await PreferencesHelper.read(PrefsKeys.paymentItems) ?? PaymentsTableColumns.values.map((e) => e.columnName).toList(); 

    emit(SettingsInitial(
      claimItems: claimItems ?? [],
      paymnetItems: paymentItems ?? []
    ));
  }

   void _mapSettingsChangedToState(
    SettingsChanged event, 
    Emitter<SettingsState> emit) async {

    emit(SettingsLoading());

    if(event.claimItem != null) {

      if(event.value) {
        claimItems?.add(event.claimItem ?? '');
      } else {
        claimItems?.remove(event.claimItem);
      }
      claimItems?.sort((a, b) => ClaimsTableColumns.values.map((e) => e.columnName).toList().indexOf(a) - ClaimsTableColumns.values.map((e) => e.columnName).toList().indexOf(b));
      await PreferencesHelper.write(PrefsKeys.claimItems, claimItems);
    }

    if(event.paymentItem != null) {
      if(event.value) {
        paymentItems?.add(event.paymentItem ?? '');
      } else {
        paymentItems?.remove(event.paymentItem);
      }
      paymentItems?.sort((a, b) => PaymentsTableColumns.values.map((e) => e.columnName).toList().indexOf(a) - PaymentsTableColumns.values.map((e) => e.columnName).toList().indexOf(b)); 
      await PreferencesHelper.write(PrefsKeys.paymentItems, paymentItems);
    }

    emit(SettingsInitial(
      claimItems: claimItems ?? [],
      paymnetItems: paymentItems ?? []
    ));
  } 
}