import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/screens/settings/widgets/widgets.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreenBody extends StatelessWidget {
  final SettingsInitial state;
  const SettingsScreenBody({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) => FullScreen(
        topSafe: false,
        bottomSafe: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.isAuthWithBiometricsAvailable &&
                state.isChangePinAvailable)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: SectionTitle('Доступ'),
              ),
            if (state.isAuthWithBiometricsAvailable)
              BiometricAuthFlag(
                value: state.authWithBiometricsFlag,
                onTap: (it) => context
                    .read<SettingsBloc>()
                    .add(SettingsChangeAuthWithBiometrics(it)),
                text: 'Вход по ${state.biometricDescription}',
              ),
            if (state.isChangePinAvailable)
              SettingsItem(
                text: 'Изменить PIN-код',
                onTap: () =>
                    context.read<SettingsBloc>().add(SettingsStartChangePin()),
              ),
            const SizedBox(height: 16),
            const SectionTitle('Аккаунт'),
            SettingsItem(
              onTap: () => Navigation.toChangePassword(context: context),
              text: 'Изменить пароль',
            )
          ],
        ),
      );
}
