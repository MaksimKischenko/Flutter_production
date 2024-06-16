import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class RegistrationSuccessScreen extends StatefulWidget {
  static const pageRoute = '/registration/success';

  const RegistrationSuccessScreen({Key? key}) : super(key: key);

  @override
  _RegistrationSuccessScreenState createState() =>
      _RegistrationSuccessScreenState();
}

class _RegistrationSuccessScreenState extends State<RegistrationSuccessScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationPinSetSuccess) {
            _registrationPinSetSuccess(
                askForBimetrics: state.askForBimetrics,
                komplatBiometricType: state.komplatBiometricType);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: FullScreen(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon/dialog_success.svg',
                          width: 76,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                          child: Text(
                            context.t.mobileScreens.registrationSuccess.title,
                            style: const TextStyle(
                              color: AppStyles.mainColorDark,
                              fontSize: 21,
                              letterSpacing: -0.1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 170,
                            child: Text(
                              context
                                  .t.mobileScreens.registrationSuccess.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppStyles.mainColorDark.withOpacity(0.5),
                                fontSize: 16,
                                letterSpacing: -0.1,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(64, 8, 64, 8),
                  child: Text(
                    context.t.mobileScreens.registrationSuccess
                        .pinSetupDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppStyles.mainColorDark.withOpacity(0.5),
                      fontSize: 16,
                      letterSpacing: -0.1,
                      fontWeight: FontWeight.w300,
                      // height: 1.2
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: BottomButton(
                    text: context
                        .t.mobileScreens.registrationSuccess.setPinButton,
                    onPressed: _onSetPinTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _onSetPinTap() {
    Multiplatform.showVerifyPinScreen(
      context: context,
      title: t.modal.pinSetup.title.first,
      confirmTitle: t.modal.pinSetup.title.repeat,
      cancelButtonTitle: t.modal.pinSetup.cancelButton,
      onSuccess: (String pin) {
        context.read<RegistrationBloc>().add(
              RegistrationSetPin(pin: pin),
            );
      },
    );
  }

  void _registrationPinSetSuccess(
      {required bool askForBimetrics,
      required KomplatBiometricType? komplatBiometricType}) {
    Navigation.toMain();
    if (askForBimetrics) {
      Multiplatform.showBiometricUseDialog(
        context: Navigation.navigatorKey.currentState!.overlay!.context,
        komplatBiometricType: komplatBiometricType!,
        buttonTitle: t.modal.biometricSetup.confirmButton,
        cancelButtonTitle: t.modal.biometricSetup.cancelButton,
      );
    }
  }
}
