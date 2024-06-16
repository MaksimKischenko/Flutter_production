import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';
import 'package:responsive_ui/responsive_ui.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late GlobalKey<FormState> _formKey; 
  late ScrollController _scrollController;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatNewPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _scrollController = ScrollController();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _oldPasswordController.dispose();
    _repeatNewPasswordController.dispose();
    _newPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordError) {
            RequestUtil.catchNetworkError(
              context: context,
              obj: state.error
            );  
          } 
          else if (state is ChangePasswordSuccess) {            
            Future.delayed(const Duration(seconds: 1), () => getIt<Routes>().pop());
            _successMessage();
            Future.delayed(const Duration(seconds: 1), () => getIt<Routes>().pop());           
          }
        },
        child: DialogWrapper(
          title: 'Смена пароля',
          buttonTitle: 'Сохранить пароль',
          onApplyPressed: _onApplyTap,
          body: RawScrollbar(
            thumbColor: AppStyles.colorGrey2,
            thumbVisibility: true,
            interactive: true,
            controller: _scrollController,            
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      minWidth: 400,
                      maxHeight: 600,
                      minHeight: 600,
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Responsive(runSpacing: 16, 
                          children: [
                            Div(
                              divison: const Division(colL: 12, colM: 12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: PasswordInputField(
                                  controller: _oldPasswordController,
                                  labelText: 'Старый пароль',
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Введите пароль';
                                    }
                                    if (value.length < 6) {
                                      return 'Минимальная длина пароля ${6} символов';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Div(
                              divison: const Division(colL: 12, colM: 12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: PasswordInputField(
                                  labelText: 'Новый пароль',
                                  controller: _newPasswordController,
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Введите пароль';
                                    }
                                    if (value.length < 6) {
                                      return 'Минимальная длина пароля ${6} символов';
                                    }
                                    if (_newPasswordController.text != _repeatNewPasswordController.text) {
                                      return 'Пароли не совпадают';
                                    } if (_oldPasswordController.text ==_newPasswordController.text) {
                                      return 'Новый пароль должен отличаться';
                                    } 
                                    
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Div(
                              divison: const Division(colL: 12, colM: 12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: PasswordInputField(
                                  controller: _repeatNewPasswordController,
                                  labelText: 'Повторите новый пароль',
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Введите пароль';
                                    }
                                    if (value.length < 6) {
                                      return 'Минимальная длина пароля ${6} символов';
                                    }
                                    if (_newPasswordController.text !=
                                        _repeatNewPasswordController.text) {
                                      return 'Пароли не совпадают';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onApplyTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      context.read<ChangePasswordBloc>().add(ChangePasswordRun(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text
      ));
    }
  }

  Future<void> _successMessage() async {
     await DialogPlatform.showMessage(
        context: context,
        title: 'Успешно',
        message: 'Пароль успешно изменен',
        type: DialogType.success
      );   
  }
}
