import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_widgets/main_widgets.dart';


@RoutePage()
class RegistrationScreen extends StatelessWidget {
  static const pageRoute = '/registration';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DismissOutside(
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationError) {
              RequestUtil.catchNetworkError(
                context: context,
                obj: state.error,
              );
            }
            if (state is RegistrationErrorKomplat) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
            }
            if (state is RegistrationSuccess) {
              _registrationSuccess(
                context: context,
                params: state.params,
                codeType: state.codeType,
              );
            }
          },
          child: const RegistrationScreenBody(),
        ),
      );

  void _registrationSuccess({
    required BuildContext context,
    required List<MdomResponseParam>? params,
    required ConfirmCodeType codeType,
  }) {
    if ((params ?? []).isEmpty) {
      SystemChannels.textInput.invokeMethod<void>('TextInput.hide');

      AutoRouter.of(context).push(RegistrationCodeRoute(codeType: codeType));

      // Navigation.toRegistrationCode(codeType: codeType);
    } else {
      SystemChannels.textInput.invokeMethod<void>('TextInput.hide');

      AutoRouter.of(context).push(
        RegistrationParamsRoute(
          params: params!.where((e) => (e.view ?? 0) == 1).toList(),
        ),
      );

      // Navigation.toRegistrationParams(
      //   params: params!.where((e) => (e.view ?? 0) == 1).toList(),
      // );
    }
  }
}
