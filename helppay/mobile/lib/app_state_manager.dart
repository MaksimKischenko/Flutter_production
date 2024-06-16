// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

import 'injection_component.dart';
import 'utils/multiplatform.dart';

class AppStateManager extends WidgetsBindingObserver {
  final GlobalKey<NavigatorState> key;
  final DataManager _dataManager;

  AppStateManager(this.key) : _dataManager = InjectionComponent.getDependency<DataManager>();



  @override
  // ignore: avoid_void_async
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // print('state = $state, safeViewVisible: ${_dataManager.safeViewVisible}, needCheckPin: ${_dataManager.needCheckPin}');
    // НЕ УБИРАТЬ! _checkPin() заходит в бесконечный цикл при использовании биометрии без needCheckPin
    if (state == AppLifecycleState.inactive && !_dataManager.safeViewVisible) {
      _dataManager.needCheckPin = true;
    } 
    if (state == AppLifecycleState.resumed
    && _dataManager.needCheckPin
    && !_dataManager.safeViewVisible) {
      final correctPin = await SecureStorageManager.read(SecureStorageKeys.pincode);
      _checkPin(correctPin!);
    } 
  }

  void _checkPin(String correctPin) {
    final canBiometric = _dataManager.isAvailableBiometricAuth && _dataManager.authWithBiometricsFlag;
    _dataManager.safeViewVisible = true;
    Multiplatform.showPinScreen(
      context: key.currentState!.overlay!.context,
      correctPin: correctPin,
      title: t.modal.pinVerify.title,
      footerTitle: t.modal.pinVerify.forgetPinButton,
      canBiometric: canBiometric,
      komplatBiometricType: _dataManager.komplatBiometricType,
      cancelButtonTitle: '',
      biometricReason: t.modal.pinVerify.biometricReason,
      onSuccess: () {
        _dataManager
          ..safeViewVisible = false
          ..needCheckPin = false;
      }
    );
  }
}
