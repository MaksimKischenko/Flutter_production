

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';
import 'package:responsive_ui/responsive_ui.dart';

class UserEditScreenBody extends StatefulWidget {

  const UserEditScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<UserEditScreenBody> createState() => _UserEditScreenBodyState();
}

class _UserEditScreenBodyState extends State<UserEditScreenBody> {

  late ScrollController _scrollController;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController; 
  late TextEditingController _loginController; 
  late TextEditingController _passwordController; 
  late UserUpdateRequest _userUpdateBody;
  late UserType selectedUserType;

  User? _user;
  bool changePassword = false;
  AutovalidateMode validateMode = AutovalidateMode.always;

  bool get isSaveAvailable {
    if (_user == null) return false;
    return _user?.name  != _nameController.text
    || _user?.login  != _loginController.text
    || _passwordController.text.length > 5
    || _user?.blocked != _userUpdateBody.blocked;
  }

 @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _nameController = TextEditingController();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _userUpdateBody = UserUpdateRequest.empty();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _loginController.dispose();
    _scrollController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Column(
        children: [
          BlocBuilder<UserUpdateBloc, UserUpdateState>(
            builder: (context, state) {
              Widget body = const SizedBox();
              if(state is UserUpdateInitial) {
              body =  ManagmentScreenTitle(
                title: typeDescriptionTitle()
               );                  
              }
              return body;
            },
          ),
          const Divider(),
          BlocConsumer<UserUpdateBloc, UserUpdateState>(
            listener: (context, state) {
              if(state is UserUpdateNetworkError) {
                RequestUtil.catchNetworkError(
                  context: context,
                  obj: state.error
                );                
              } else if (state is UserUpdateInitial) {
                _onInitialState(state);
              } else if (state is UserUpdateSuccess) {
                _onPopWithArgs(state.user);              
              }
            },
            builder: (context, state) {
              Widget body = const SizedBox();
              if(state is UserUpdateLoading) {
                body = const Expanded(
                  child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                );
              } else if (state is UserUpdateInitial) {
                body = Expanded(
                  child: RawScrollbar(
                    thumbColor: AppStyles.colorGrey2,
                    thumbVisibility: true,
                    interactive: true,
                    controller: _scrollController,              
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),   
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 1000
                            ),   
                            child: Form(
                              key: _formKey,
                              child: Responsive(
                                runSpacing: 16,
                                children: [
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,                  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: InputField(                                       
                                        isReadOnly: true,
                                        labelText: UserActionFieldNames.date.message,
                                        initialValue: _user?.dateAdd?.toStringFormatted()
                                      )
                                    )
                                  ),     
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,                  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: InputField(
                                        controller: _nameController,
                                        mandatory: true,
                                        labelText: UserActionFieldNames.name.message,
                                        onSaved: (value) {
                                          if (_user?.name != value) {
                                            _userUpdateBody = _userUpdateBody.copyWith(
                                              name: value
                                            );
                                          } else {
                                            _userUpdateBody = _userUpdateBody.copyWith(
                                              name: null
                                            );
                                          }                                           
                                        },
                                        onChanged: (_) => setState(() {}),                                        
                                      )
                                    )
                                  ), 
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,                  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                      child: InputField(
                                        mandatory: true,
                                        controller: _loginController,
                                        labelText: UserActionFieldNames.login.message,
                                        onSaved: (value) {
                                          if (_user?.name != value) {
                                            _userUpdateBody = _userUpdateBody.copyWith(
                                              login: value
                                            );
                                          } else {
                                            _userUpdateBody = _userUpdateBody.copyWith(
                                              login: null
                                            );
                                          }                                           
                                        },
                                        onChanged: (_) => setState(() {}),                                                                                
                                      )
                                    )
                                  ),    
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,                  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                      child: InputField(
                                        isReadOnly: true,
                                        initialValue: _user?.type?.name ?? '',
                                        labelText: UserActionFieldNames.role.message,                                        
                                      )
                                    )
                                  ),   
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: PasswordInputField(
                                        mandatory: false,
                                        isReadOnly: !changePassword,
                                        controller: _passwordController,
                                        labelText: DataSourceActionFieldNames.password.message,
                                        onSaved: (value) {
                                          _userUpdateBody = _userUpdateBody.copyWith(
                                            password: value
                                          );                                     
                                        },
                                        onChanged: (value) => setState(() {}),                                                                                                                        
                                      ),
                                      
                                    )
                                  ),  
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,                  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: StatusSwitcher(
                                        value: changePassword,
                                        text: UserActionFieldNames.resetPassword.message,
                                        onChanged: (value) => 
                                        setState(() {
                                          changePassword = !changePassword;
                                          _passwordController.clear();
                                        }),
                                      )
                                    )
                                  ),                                                                                                                                                                                                       
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,                  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: StatusSwitcher(
                                        value: _userUpdateBody.blocked ?? false,
                                        text: UserActionFieldNames.enable.message,
                                        onChanged: (value) => setState(() {
                                          _userUpdateBody = _userUpdateBody.copyWith(
                                           blocked : value
                                          );
                                        }),
                                      )
                                    )
                                  ),                                                                                                                                                                                                        
                                ],
                              ),
                            ),                   
                          ),
                        ),              
                      ),
                    ),
                  )
                );
              }
              return body;
            },
          ),
          const Divider(),         
          Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SubmitButton(
                  isActive: isSaveAvailable,
                  name: ButtonNames.save.message,
                  onTap: _onSaveTap,
                ),
                const SizedBox(width: 10),
                SubmitButton(
                  name: ButtonNames.cancel.message,
                  onTap: _onBackTap,
                )
              ],
            ),
          ),                         
        ],
      ),
    );


  void _onInitialState(UserUpdateInitial state) {
    _user = state.user;
    selectedUserType = state.userTypes.firstWhere((element) => element.id == _user?.type, orElse: () => UserType(id: 0, name: ''));
    _userUpdateBody = _userUpdateBody.copyWith(blocked: state.user?.blocked ?? false);
    _nameController.text = state.user?.name ?? '';
    _loginController.text = state.user?.login ?? '';    
  }

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<UserUpdateBloc>().add(UserUpdateRun(_userUpdateBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const UsersRoute(), predicate: (route) => false);
    }
  } 

  void _onPopWithArgs(User? args) {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop<User>(args);
    } else {
      AutoRouter.of(context).popAndPush(const UsersRoute(),result: args);
    }    
  }     

  String typeDescriptionTitle() {
    var description = '';
    switch (_user?.type?.id) {
      case 1:
        description = 'Редактирование администратора';
        break;
      case 2:
        description = 'Редактирование пользователя';
        break;
      case 4:
        description = 'Редактирование просмотра пользователей';
        break;                
    }
    return description;
  } 
}