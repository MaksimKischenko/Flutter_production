import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/registration_params/main_widgets/reqistration_params_screen_body.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegistrationParamsScreen extends StatefulWidget {
  // static const pageRoute = '/registration/params';
  static const pageRoute = '${RegistrationScreen.pageRoute}/:params';
  final List<MdomResponseParam> params;

  const RegistrationParamsScreen({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  _RegistrationParamsScreenState createState() =>
      _RegistrationParamsScreenState();
}

class _RegistrationParamsScreenState extends State<RegistrationParamsScreen> {
  late List<MdomResponseParam> paramsCopy;

  final _paramsFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    paramsCopy = List.from(widget.params);
  }

  @override
  Widget build(BuildContext context) => DismissOutside(
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationError) {
              RequestUtil.catchNetworkError(
                context: context,
                obj: state.error,
              );
            } else if (state is RegistrationErrorKomplat) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
            } else if (state is RegistrationSuccessEdit) {
              _registrationSuccessEdit(codeType: state.codeType);
            }
          },
          child: RegistrationParamsScreenBody(
            onProceedTap: _onProceedTap,
            paramsCopy: paramsCopy,
            paramsFormKey: _paramsFormKey,
          ),
        ),
      );

  void _onProceedTap() {
    if (_paramsFormKey.currentState?.validate() ?? false) {
      _paramsFormKey.currentState?.save();

      context
          .read<RegistrationBloc>()
          .add(RegistrationParamsEntryCompleted(params: paramsCopy));
    }
  }

  void _registrationSuccessEdit({required ConfirmCodeType codeType}) {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');

    AutoRouter.of(context).push(RegistrationCodeRoute(codeType: codeType));

    // Navigation.toRegistrationCode(codeType: codeType);
  }
}
