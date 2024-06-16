import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart' as widgets;
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  final ScrollController controller;

  const ChangePasswordScreen({
    required this.controller
  });

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final _changePasswordFormKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordRepeatController = TextEditingController();

  final _titleKey = GlobalKey();

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle => widget.controller.hasClients
      && widget.controller.offset - titleSize > 0;

  final _changePasswordData = ChangePasswordData();

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;  
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordRepeatController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: ScreenTitle(
      text: _showTitle
          ? context.t.mobileScreens.changePassword.title
          : '',
      actionWidget: SaveButton(
        text: context.t.mobileScreens.changePassword.saveButton,
        onPressed: _onSaveTap,
      ),
    ),
    child: widgets.FullScreen(
      bottomSafe: false,
      controller: widget.controller,
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordError) {
            RequestUtil.catchNetworkError(
              context: context,
              obj: state.error
            );
          }
          if (state is ChangePasswordErrorKomplat) {
            RequestUtil.catchKomplatError(
              context: context,
              errorCode: state.errorCode,
              errorText: state.errorMessage
            );
          }
          if (state is ChangePasswordSuccess) {
            _changePasswordSuccess();
          }
        },
        buildWhen: (prevState, currState) {
          if (currState is ChangePasswordErrorKomplat) return false;
          if (currState is ChangePasswordError) return false;
          return true;
        },
        builder: (context, state) {
          Widget body = Container();

          if (state is ChangePasswordLoading) {
            body = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const widgets.MultiplatformIndicator(),
                const SizedBox(height: 16),
                Text(
                  context.t.mobileScreens.changePassword.loadingTitle,
                  style: TextStyle(
                    color: AppStyles.mainColorDark.withOpacity(0.5),
                    fontSize: 16,
                    // fontWeight: FontWeight.w600
                  ),
                )
              ],
            );
          }
          if (state is ChangePasswordInitial) {
            body = Form(
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
                        text: context.t.mobileScreens.changePassword.title,
                      )
                    ),
                    PasswordField(
                      controller: _oldPasswordController,
                      labelText: context.t.mobileScreens.changePassword.oldPasswordField.title,
                      hintText: '',
                      onSaved: (text) {
                        _changePasswordData.oldPassword = CoreConfig.passwordCrypter(text);
                      },
                      validator: (text) {
                        if (state.oldPassword != CoreConfig.passwordCrypter(text)) {
                          return context.t.mobileScreens.changePassword.oldPasswordField.errors.incorrect;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _newPasswordController,
                      labelText: context.t.mobileScreens.changePassword.newPasswordField.title,
                      hintText: '',
                      onSaved: (text) {
                        _changePasswordData.newPassword = CoreConfig.passwordCrypter(text);
                      },
                      validator: (text) {
                        if (_newPasswordController.text != _newPasswordRepeatController.text) {
                          return context.t.mobileScreens.changePassword.newPasswordField.errors.passwordsNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _newPasswordRepeatController,
                      labelText: context.t.mobileScreens.changePassword.newPasswordRepeatField.title,
                      hintText: '',
                      validator: (text) {
                        if (_newPasswordController.text != _newPasswordRepeatController.text) {
                          return context.t.mobileScreens.changePassword.newPasswordRepeatField.errors.passwordsNotMatch;
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return body;
        },
      )
    ),
  );

  void _onSaveTap() {
    if (_changePasswordFormKey.currentState?.validate() ?? false) {
      _changePasswordFormKey.currentState?.save();

      context.read<ChangePasswordBloc>().add(
        ChangePasswordAction(
          oldPassword: _changePasswordData.oldPassword!,
          newPassword: _changePasswordData.newPassword!
        )
      );
    }
  }

  void _changePasswordSuccess() {
    Navigator.of(context).pop();
  }
}