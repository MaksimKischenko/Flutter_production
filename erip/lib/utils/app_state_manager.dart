import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppStateManager extends WidgetsBindingObserver {
  final GlobalKey<NavigatorState> key;

  final DataManager _dataManager;

  AppStateManager({
    required this.key
  }) : _dataManager = InjectionComponent.getDependency<DataManager>();

  @override
  // ignore: avoid_void_async
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    //print('state = $state');
    // НЕ УБИРАТЬ! _checkPin() заходит в бесконечный цикл при использовании биометрии без needCheckPin
    if (state == AppLifecycleState.inactive && !_dataManager.safeViewVisible && _dataManager.isCredentialsSaveChecked) {
      _dataManager.needCheckPin = true;
    }
    if (state == AppLifecycleState.resumed
    && _dataManager.needCheckPin
    && !_dataManager.safeViewVisible
    && _dataManager.isCredentialsSaveChecked) {
      final correctPin = await SecureStorageManager.getPinCode();
      _checkPin(correctPin!);
    }
  }

  void _checkPin(String correctPin) {
    final canBiometric = _dataManager.isAvailableBiometricAuth && _dataManager.authWithBiometricsFlag;
    _dataManager.safeViewVisible = true;
    Multiplatform.showPinScreen(
      context: key.currentState!.overlay!.context,
      correctPin: correctPin,
      canBiometric: canBiometric,
      komplatBiometricType: _dataManager.komplatBiometricType,
      onSuccess: () {
        _dataManager
          ..safeViewVisible = false
          ..needCheckPin = false;
      }
    );
  }

}