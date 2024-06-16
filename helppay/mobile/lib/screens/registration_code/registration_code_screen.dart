import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class RegistrationCodeScreen extends StatefulWidget {
  static const pageRoute = '/registration/code';

  final ConfirmCodeType codeType;

  const RegistrationCodeScreen({
    required this.codeType
  });

  @override
  _RegistrationCodeScreenState createState() => _RegistrationCodeScreenState();
}

class _RegistrationCodeScreenState extends State<RegistrationCodeScreen> {
  final _codeFormKey = GlobalKey<FormState>();

  int? _code;

  @override
  Widget build(BuildContext context) => BlocListener<RegistrationBloc, RegistrationState>(
    listener: (context, state) {
      if (state is RegistrationError) {
        RequestUtil.catchNetworkError(
          context: context,
          obj: state.error
        );
      }
      if (state is RegistrationErrorKomplat) {
        RequestUtil.catchKomplatError(
          context: context,
          errorCode: state.errorCode,
          errorText: state.errorMessage
        );
      }
      if (state is RegistrationCodeSendSuccess) {
        Navigation.toRegistrationSuccess();
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
                    const SizedBox(height: 16),
                    SvgPicture.asset('assets/images/logo.svg'),
                    const SizedBox(height: 64),
                    Text(
                      context.t.mobileScreens.registrationCode.title,
                      style: AppStyles.headerTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Form(
                        key: _codeFormKey,
                        child: CodeField(
                          codeType: widget.codeType,
                          onSaved: (value) {
                            _code = value.toIntOrNull();
                          },
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: RegistrationApplyButton(
                text: context.t.mobileScreens.registrationCode.applyButton,
                onPressed: _onProceedTap,
              ),
            ),
          ],
        ),
      ),
    )
  );

  void _onProceedTap() {
    if (_codeFormKey.currentState?.validate() ?? false) {
      _codeFormKey.currentState?.save();
      
      context.read<RegistrationBloc>().add(
        RegistrationCodeSend(
          code: _code!
        )
      );
    }
  }

}