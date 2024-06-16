import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class RegistrationCodeScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/registration_code');

  static const pageRoute = '/registration/code';

  final ConfirmCodeType? codeType;

  const RegistrationCodeScreen({this.codeType});

  @override
  _RegistrationCodeScreenState createState() => _RegistrationCodeScreenState();
}

class _RegistrationCodeScreenState extends State<RegistrationCodeScreen> {
  final _codeFormKey = GlobalKey<FormState>();

  int? _code;

  @override
  void initState() {
    super.initState();
    if (widget.codeType == null) {
      AutoRouter.of(context).push(const RegistrationRoute());
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is RegistrationErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          }
          if (state is RegistrationCodeSendSuccess) {
            AutoRouter.of(context).pushAndPopUntil(
                const RegistrationSuccessRoute(),
                predicate: (route) => false);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 360, maxHeight: 600),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      SvgPicture.asset('assets/images/logo.svg'),
                      const SizedBox(height: 64),
                      Text(
                        context.t.mobileScreens.registrationCode.title,
                        style: AppStyles.headerTextStyle,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Form(
                            key: _codeFormKey,
                            child: CodeField(
                              codeType: widget.codeType,
                              onSaved: (value) {
                                _code = value.toIntOrNull();
                              },
                            ),
                          )),
                      RegistrationApplyButton(
                        text: context
                            .t.mobileScreens.registrationCode.applyButton,
                        onPressed: _onProceedTap,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onProceedTap() {
    if (_codeFormKey.currentState?.validate() ?? false) {
      _codeFormKey.currentState?.save();
      context.read<RegistrationBloc>().add(RegistrationCodeSend(code: _code!));
    }
  }
}
