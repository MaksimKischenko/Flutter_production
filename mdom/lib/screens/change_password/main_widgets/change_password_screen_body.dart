import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/config.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart' as widgets;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../widgets/widgets.dart';

class ChangePasswordScreenBody extends StatefulWidget {
  final ScrollController? controller;

  const ChangePasswordScreenBody({
    super.key,
    this.controller,
  });

  @override
  State<ChangePasswordScreenBody> createState() =>
      _ChangePasswordScreenBodyState();
}

class _ChangePasswordScreenBodyState extends State<ChangePasswordScreenBody> {
  final _changePasswordFormKey = GlobalKey<FormState>();

  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final newPasswordRepeat = TextEditingController();

  final _titleKey = GlobalKey();

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      (widget.controller?.hasClients ?? false) &&
      (widget.controller?.offset ?? 0) - titleSize > 0;

  final _changePasswordData = ChangePasswordData();

  final _nodeOldPassword = FocusNode();
  final _nodeNewPassword = FocusNode();
  final _nodeNewPasswordRepeat = FocusNode();

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(() {
      if (_isTitleVisible != _showTitle) {
        setState(() {
          _isTitleVisible = !_isTitleVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    newPasswordRepeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widgets.DismissOutside(
        child: Scaffold(
          appBar: ScreenTitle(
            text: _showTitle ? 'Изменить пароль' : '',
            actionWidget: SaveButton(
              text: 'Изменить',
              onPressed: _onSaveTap,
            ),
          ),
          body: KeyboardActions(
            config: keyboardConfig,
            disableScroll: true,
            child: widgets.FullScreen(
                bottomSafe: false,
                controller: widget.controller,
                child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordError) {
                      RequestUtil.catchNetworkError(
                          context: context, obj: state.error);
                    } else if (state is ChangePasswordErrorKomplat) {
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
                    } else if (state is ChangePasswordSuccess) {
                      _changePasswordSuccess();
                    }
                  },
                  child: Form(
                    key: _changePasswordFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 24),
                              child: widgets.PageTitle(
                                key: _titleKey,
                                text: 'Изменить пароль',
                              )),
                          PasswordField(
                            focusNode: _nodeOldPassword,
                            controller: oldPassword,
                            labelText: 'Старый пароль',
                            hintText: '',
                            onSaved: (text) {
                              _changePasswordData.oldPassword =
                                  AppConfig.passwordCrypter(text);
                            },
                          ),
                          const SizedBox(height: 16),
                          PasswordField(
                            focusNode: _nodeNewPassword,
                            controller: newPassword,
                            labelText: 'Новый пароль',
                            hintText: '',
                            onSaved: (text) {
                              _changePasswordData.newPassword =
                                  AppConfig.passwordCrypter(text);
                            },
                            validator: (text) {
                              if (text != newPasswordRepeat.text) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          PasswordField(
                            focusNode: _nodeNewPasswordRepeat,
                            controller: newPasswordRepeat,
                            labelText: 'Подтвердите новый пароль',
                            hintText: '',
                            validator: (text) {
                              if (text != newPassword.text) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      );

  KeyboardActionsConfig get keyboardConfig =>
      AppStyles.keyboardConfig(actions: [
        KeyboardActionsItem(
            focusNode: _nodeOldPassword,
            displayDoneButton: false,
            displayActionBar: false),
        KeyboardActionsItem(
            focusNode: _nodeNewPassword,
            displayDoneButton: false,
            displayActionBar: false),
        KeyboardActionsItem(
            focusNode: _nodeNewPasswordRepeat,
            displayDoneButton: false,
            displayActionBar: false),
      ]);

  void _onSaveTap() {
    if (_changePasswordFormKey.currentState?.validate() ?? false) {
      _changePasswordFormKey.currentState?.save();

      context.read<ChangePasswordBloc>().add(ChangePasswordProceed(
          oldPassword: _changePasswordData.oldPassword!,
          newPassword: _changePasswordData.newPassword!));
    }
  }

  void _changePasswordSuccess() {
    Navigator.of(context).pop();
    Multiplatform.showMessage<void>(
      context: context,
      title: 'Успешно',
      message: 'Пароль изменён',
      type: DialogType.success,
    );
  }
}
