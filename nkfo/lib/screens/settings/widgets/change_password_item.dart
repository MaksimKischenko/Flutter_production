
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_cabinet_nkfo/blocs/change_password/change_password_bloc.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ChangePasswordItem extends StatefulWidget {

  
  @override
  _ChangePasswordItemState createState() => _ChangePasswordItemState();
}

class _ChangePasswordItemState extends State<ChangePasswordItem> {
  bool get isSaveAvailable => _passwordController.text.length > 5
  && _newPasswordController.text.length > 5
  && _newPasswordRepeatController.text.length > 5
  && _passwordController.text != _newPasswordController.text
  && _newPasswordController.text == _newPasswordRepeatController.text;
  
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmNewPasswordFocusNode = FocusNode();


  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordRepeatController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _newPasswordRepeatController.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordFocusNode.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) => Expanded(
    child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordError) {
          RequestUtil.catchNetworkError(context: context, obj: state.error);
        } else if (state is ChangePasswordSuccess) {
          Multiplatform.showMessage(
            context: context,
            title: 'Успешно',
            message: 'Пароль пользователя успешно изменен',
            type: DialogType.success
          );
        } 
      },
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('Смена пароля', style: AppStyles.headerTextStyle),
          const SizedBox(height: 20),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  var width = 800.0;
                  if (sizingInformation.isMobile || sizingInformation.isTablet) {
                    width = sizingInformation.screenSize.width;
                  }
                  return SizedBox(
                    width: width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          PasswordTextField(
                            controller: _passwordController,
                            focusNode: _oldPasswordFocusNode,
                            labelText: 'Старый пароль',
                            onChanged: (_) => setState(() {}),
                            onFieldSubmitted: (_) {
                              _oldPasswordFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(_newPasswordFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле обязательное для заполнения';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              PasswordTextField(
                                controller: _newPasswordController,
                                focusNode: _newPasswordFocusNode,
                                labelText: 'Новый пароль',
                                onChanged: (_) => setState(() {}),
                                onFieldSubmitted: (_) {
                                  _newPasswordFocusNode.unfocus();
                                  FocusScope.of(context).requestFocus(_confirmNewPasswordFocusNode);
                                },                              
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Поле обязательное для заполнения';
                                  } else if (value.length < 6) {
                                    return 'Пароль должен содержать не менее 6 символов';
                                  } else if (value == _passwordController.text) {
                                    return 'Новый пароль не должен совпадать со старым';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(width: 12),
                              const Tooltip(
                                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                                message: AppConfig.passwordInfo,
                                child:  Icon(Icons.info_outlined, size: 20, color: AppStyles.mainColor)
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          PasswordTextField(
                            controller: _newPasswordRepeatController,
                            focusNode: _confirmNewPasswordFocusNode,
                            labelText: 'Повторите новый пароль',
                            onChanged: (_) => setState(() {}),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле обязательное для заполнения';
                              } else if (value != _newPasswordController.text) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // UndoButton(onTap: () => Navigator.of(context).pop()),
                // const SizedBox(width: 10),
                SaveButton(
                  onTap: _onSaveTap,
                  isAvaible: isSaveAvailable
                )
              ],
            ),
          ),
        ],
      )
    ),
  );

   
  void _onSaveTap() {
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<ChangePasswordBloc>().add(ChangePasswordRun(
        password: _passwordController.text,
        newPassword: _newPasswordController.text
      ));
    }
  }
}