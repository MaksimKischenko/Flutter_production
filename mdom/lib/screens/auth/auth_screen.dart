import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_widgets/main_widget.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  static const pageRoute = '/auth';

  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) => DismissOutside(
        child: BlocListener<AuthMdomBloc, AuthMdomState>(
          listener: (context, state) {
            if (state is AuthUnauthorized) {
              if (state.needToNavigate) {
                AutoRouter.of(context).pushAndPopUntil(const AuthRoute(),
                    predicate: (route) => false);
              } //push(AuthRoute());
            } else if (state is AuthAuthorized) {
              if (state.needToNavigate) {
                AutoRouter.of(context).push(
                    kIsWeb ? const PollsListRoute() : const MainRouteMobile());
              }
            } else if (state is AuthMdomError) {
              RequestUtil.catchNetworkError(context: context, obj: state.error);
            } else if (state is AuthMdomErrorKomplat) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
              if (state.errorCode == 119) {
                Future.delayed(
                  const Duration(seconds: 2),
                  () => AutoRouter.of(context).push(const AuthRoute()),
                );
              }
            } else if (state is AuthMdomAskForBiometrics) {
              _onAuthAskForBiometrics(state.biometricDescription, context);
            } else if (state is AuthMdomSuccessLogin) {
              _onAuthSuccessLogin(context);
            } else if (state is AuthMdomPinSetup) {
              _onAuthPinSetup(context);
            }
          },
          child: const Scaffold(
            body: AuthScreenBody(),
          ),
        ),
      );

  void _onAuthSuccessLogin(BuildContext context) {
    AutoRouter.of(context)
        .push(kIsWeb ? const PollsListRoute() : const MainRouteMobile());
  }

  void _onAuthPinSetup(BuildContext context) {
    Multiplatform.showVerifyPinScreen(
        context: context,
        title: 'Придумайте PIN',
        onSuccess: (String pin) =>
            context.read<AuthMdomBloc>().add(AuthMdomSetPin(pin)));
  }

  void _onAuthAskForBiometrics(
    String biometricDescription,
    BuildContext context,
  ) {
    Multiplatform.showDecisionMessage(
      context: context,
      message: null,
      action: () => context
          .read<AuthMdomBloc>()
          .add(const AuthMdomBiometricResponse(true)),
      dialogTitle: 'Использовать $biometricDescription для входа в приложение?',
      buttonTitle: 'Да',
      cancelButtonTitle: 'Нет',
      cancelAction: () => context
          .read<AuthMdomBloc>()
          .add(const AuthMdomBiometricResponse(false)),
      dangetType: DecisionType.neutral,
      barrierDismissible: false,
    );
  }
}
