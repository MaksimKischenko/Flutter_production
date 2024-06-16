// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final DataManager dataManager;
  
  SettingsBloc({
    required this.dataManager
  }) : super(SettingsLoading()) {
    on<SettingsEvent>(_onEvent);
  }

  void _onEvent(
    SettingsEvent event,
    Emitter<SettingsState> emit
  ) {
    if (event is SettingsInit) return _onSettingsInit(event, emit);
    if (event is SettingsSave) return _onSettingsSave(event, emit);
  }

  void _onSettingsInit(
    SettingsInit event,
    Emitter<SettingsState> emit
  ) async {
    emit(SettingsLoading());

    final terminalId = await PreferencesHelper.read(PrefsKeys.terminalId);
    final pan = await PreferencesHelper.read(PrefsKeys.pan);
    final typePan = await PreferencesHelper.read(PrefsKeys.typePan);
    final resourcesUrl = await PreferencesHelper.read(PrefsKeys.resourcesUrl);
    final servletName = await PreferencesHelper.read(PrefsKeys.servletName);
    final connectionTimeout = await PreferencesHelper.read(PrefsKeys.connectionTimeout);
    final receiveTimeout = await PreferencesHelper.read(PrefsKeys.receiveTimeout);
    final modalActivityTimeout = await PreferencesHelper.read(PrefsKeys.modalActivityTimeout);
    final waitingTimeout = await PreferencesHelper.read(PrefsKeys.waitingTimeout);
    final monitoringTimeout = await PreferencesHelper.read(PrefsKeys.monitoringTimeout);

    emit(SettingsLoaded(SettingsData(
      terminalId: terminalId!,
      pan: pan!,
      typePan: typePan!,
      resourcesUrl: resourcesUrl!,
      servletName: servletName!,
      connectionTimeout: connectionTimeout!,
      receiveTimeout: receiveTimeout!,
      modalActivityTimeout: modalActivityTimeout!,
      waitingTimeout: waitingTimeout!,
      monitoringTimeout: monitoringTimeout!
    )));
  }

  void _onSettingsSave(
    SettingsSave event,
    Emitter<SettingsState> emit
  ) async {
    emit(SettingsLoading());

    await PreferencesHelper.write(PrefsKeys.terminalId, event.data.terminalId);
    await PreferencesHelper.write(PrefsKeys.pan, event.data.pan);
    await PreferencesHelper.write(PrefsKeys.typePan, event.data.typePan);
    await PreferencesHelper.write(PrefsKeys.resourcesUrl, event.data.resourcesUrl);
    await PreferencesHelper.write(PrefsKeys.servletName, event.data.servletName);
    await PreferencesHelper.write(PrefsKeys.connectionTimeout, event.data.connectionTimeout);
    await PreferencesHelper.write(PrefsKeys.receiveTimeout, event.data.receiveTimeout);
    await PreferencesHelper.write(PrefsKeys.modalActivityTimeout, event.data.modalActivityTimeout);
    await PreferencesHelper.write(PrefsKeys.waitingTimeout, event.data.waitingTimeout);
    await PreferencesHelper.write(PrefsKeys.monitoringTimeout, event.data.monitoringTimeout);

    emit(SettingsSaved());
    emit(SettingsLoaded(event.data));
  }
}
