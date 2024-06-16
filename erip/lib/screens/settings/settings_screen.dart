import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Настройки'),
    ),
    body: BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsCheckOldPin) {
          _settingsCheckOldPin(
            context: context,
            oldPin: state.oldPin
          );
        }
        if (state is SettingsPinChangedSuccess) {
          Multiplatform.showMessage<void>(
            context: context,
            title: 'Успешно',
            message: 'PIN-код измененён',
            type: DialogType.success
          );
        }
      },
      buildWhen: (_, newState) {
        if (newState is SettingsLoading) return true;
        if (newState is SettingsInitial) return true;
        return false;
      },
      builder: (context, state) {
        Widget body = Container();

        if (state is SettingsLoading) {
          body = const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
              ),
              LoadingIndicator()
            ],
          );
        }
        if (state is SettingsInitial) {
          body = FullScreen(
            topSafe: false,
            bottomSafe: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.isAuthWithBiometricsAvailable)
                  BiometricAuthFlag(
                    value: state.authWithBiometricsFlag,
                    onTap: (it) => context.read<SettingsBloc>().add(
                      SettingsChangeAuthWithBiometrics(it)
                    ),
                    text: 'Вход по ${state.biometricDescription}',
                  ),
                if (state.isChangePinAvailable)
                  ChangePinItem(
                    onTap: () => context.read<SettingsBloc>().add(SettingsStartChangePin()),
                  )
              ],
            ),
          );
        }

        return body;
      },
    )
  );

  void _settingsCheckOldPin({
    required BuildContext context,
    required String oldPin
  }) {
    Multiplatform.showPinScreen(
      context: context,
      correctPin: oldPin,
      canBiometric: false,
      canCancel: true,
      onSuccess: () {
        Multiplatform.showVerifyPinScreen(
          context: context,
          title: 'Введите новый PIN',
          onSuccess: (String pin) => context.read<SettingsBloc>().add(
            SettingsChangePin(pin)
          )
        );
      }
    );
  }
}