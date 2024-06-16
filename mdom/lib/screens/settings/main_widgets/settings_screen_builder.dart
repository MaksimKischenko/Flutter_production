import 'package:bpc/blocs/settings/settings_bloc.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/settings/main_widgets/main_widgets.dart';
import 'package:bpc/utils/multiplatform.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettinsScreenBodyBuilder extends StatefulWidget {
  const SettinsScreenBodyBuilder({super.key});

  @override
  State<SettinsScreenBodyBuilder> createState() =>
      _SettinsScreenBodyBuilderState();
}

class _SettinsScreenBodyBuilderState extends State<SettinsScreenBodyBuilder> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(SettingsInit());
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsCheckOldPin) {
            _settingsCheckOldPin(context: context, oldPin: state.oldPin);
          } else if (state is SettingsPinChangedSuccess) {
            Multiplatform.showMessage<void>(
                context: context,
                title: 'Успешно',
                message: 'PIN-код измененён',
                type: DialogType.success);
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
            body = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: double.maxFinite),
                LoadingIndicator()
              ],
            );
          } else if (state is SettingsInitial) {
            body = SettingsScreenBody(
              state: state,
            );
          }

          return body;
        },
      );

  void _settingsCheckOldPin(
      {required BuildContext context, required String oldPin}) {
    Multiplatform.showPinScreen(
      context: context,
      correctPin: oldPin,
      canBiometric: false,
      canCancel: true,
      onSuccess: () {
        Multiplatform.showVerifyPinScreen(
            context: context,
            title: 'Введите новый PIN',
            onSuccess: (String pin) =>
                context.read<SettingsBloc>().add(SettingsChangePin(pin)));
      },
    );
  }
}
