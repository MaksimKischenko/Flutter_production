import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_widget/main_widgets.dart';


@RoutePage()
class RegistrationSuccessScreen extends StatefulWidget {
  // static const pageRoute = '/registration/success';
  static const pageRoute = '${RegistrationScreen.pageRoute}/:success';
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
            _registrationPinSetSuccess();
          } else if (state is RegistrationAskForBiometrics) {
            _onRegistrationAskForBiometrics(state.biometricDescription);
          }
        },
        child: const Scaffold(
          body: RegistrationSuccessScreenBody(),
        ),
      );

  void _registrationPinSetSuccess() {
    // Navigation.toHome();
    AutoRouter.of(context)
        .push(kIsWeb ? const PollsListRoute() : const MainRouteMobile());

    // Navigation.toMain();
  }

  void _onRegistrationAskForBiometrics(
    String biometricDescription,
  ) {
    Multiplatform.showDecisionMessage(
      context: context,
      message: null,
      action: () => context
          .read<RegistrationBloc>()
          .add(const RegistrationBiometricResponse(true)),
      dialogTitle: 'Использовать $biometricDescription для входа в приложение?',
      buttonTitle: 'Да',
      cancelButtonTitle: 'Нет',
      cancelAction: () => context
          .read<RegistrationBloc>()
          .add(const RegistrationBiometricResponse(false)),
      dangetType: DecisionType.neutral,
      barrierDismissible: false,
    );
  }
}
