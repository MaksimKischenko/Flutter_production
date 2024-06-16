// ignore_for_file: missing_enum_constant_in_switch

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'mdom_notification_bloc');

class AuthWithBiometricsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (context, state) => false,
        builder: (context, state) {
          Widget body = Container();
          if (state is ProfileInitial) {
            if (state.isAvailableBiometricAuth) {
              late String biometricDescription;
              switch (state.komplatBiometricType) {
                case KomplatBiometricType.faceid:
                  biometricDescription = 'Face ID';
                  break;
                case KomplatBiometricType.touchid:
                  biometricDescription = 'Touch ID';
                  break;
                case KomplatBiometricType.biometric:
                  biometricDescription = context.t.mobileScreens.settings
                      .authWithBiometricsItem.biometricDescription;
                  break;
                default:
                  biometricDescription = '';
                  break;
              }
              body = SettingsItemSwitch(
                value: state.authWithBiometricsFlag,
                onChanged: (value) {
                  context
                      .read<ProfileBloc>()
                      .add(ProfileChangeAuthWithBiometrics(value: value));
                },
                text: context.t.mobileScreens.settings.authWithBiometricsItem
                    .message(
                  biometricDescription: biometricDescription,
                ),
              );
            }
          }
          return body;
        },
      );
}
