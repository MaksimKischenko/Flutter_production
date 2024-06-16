import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'main_widgets.dart';

class RegistrationScreenBody extends StatefulWidget {
  const RegistrationScreenBody({super.key});

  @override
  State<RegistrationScreenBody> createState() => _RegistrationScreenBodyState();
}

class _RegistrationScreenBodyState extends State<RegistrationScreenBody> {
  double get titleSize => 176;

  late ScrollController _scrollController;
  bool _isTitleVisible = false;
  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  final _registrationFormKey = GlobalKey<FormState>();
  final _nodeEmail = FocusNode();
  final _nodePassword = FocusNode();
  final _nodePasswordRepeat = FocusNode();
  final bool _isSmsChecked = false;
  final _data = RegistrationScreenData();

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_isTitleVisible != _showTitle) {
        setState(() {
          _isTitleVisible = !_isTitleVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: _showTitle ? const Text('Регистрация') : null,
          backgroundColor: Colors.transparent,
        ),
        body: WebConstrainedBox(
          child: KeyboardActions(
            config: keyboardConfig,
            disableScroll: true,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: FullScreen(
                      controller: _scrollController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Image.asset(
                            'assets/images/main-logo.png',
                            width: 130,
                          ),
                          const SizedBox(height: 64),
                          const Text(
                            'Регистрация',
                            style: TextStyle(
                              color: AppStyles.mainTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                            child: RegistrationScreenFormFields(
                              isSmsChecked: _isSmsChecked,
                              registrationFormKey: _registrationFormKey,
                              data: _data,
                              nodeEmail: _nodeEmail,
                              nodePassword: _nodePassword,
                              nodePasswordRepeat: _nodePasswordRepeat,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: RegistrationApplyButton(
                      text: 'Продолжить',
                      onPressed: _onProceedTap,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  KeyboardActionsConfig get keyboardConfig =>
      AppStyles.keyboardConfig(actions: [
        KeyboardActionsItem(
          focusNode: _nodeEmail,
          displayDoneButton: false,
          displayActionBar: false,
        ),
        KeyboardActionsItem(
          focusNode: _nodePassword,
          displayDoneButton: false,
          displayActionBar: false,
        ),
        KeyboardActionsItem(
          focusNode: _nodePasswordRepeat,
          displayDoneButton: false,
          displayActionBar: false,
        ),
      ]);

  void _onProceedTap() {
    if (_registrationFormKey.currentState?.validate() ?? false) {
      _registrationFormKey.currentState?.save();
      _data.isSendCodeSMS = _isSmsChecked;

      context.read<RegistrationBloc>().add(RegistrationRun(data: _data));
    }
  }
}
