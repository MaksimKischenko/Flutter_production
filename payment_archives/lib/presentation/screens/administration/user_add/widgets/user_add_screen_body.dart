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

class UserAddScreenBody extends StatefulWidget {
  final int selectedTypeId;

  const UserAddScreenBody({
    Key? key,
    required this.selectedTypeId,
  }) : super(key: key);


  @override
  State<UserAddScreenBody> createState() => _UserAddScreenBodyState();
}

class _UserAddScreenBodyState extends State<UserAddScreenBody> {

  late ScrollController _controller;
  late GlobalKey<FormState> _formKey;
  late UserInsertRequest _userInsertBody;


 @override
  void initState() {
    super.initState();
    _controller = ScrollController(); 
    _formKey = GlobalKey<FormState>();
    _userInsertBody = UserInsertRequest.empty();
  }

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: [
            ManagmentScreenTitle(title: typeDescriptionTitle()),
            const Divider(),
            BlocConsumer<UserInsertBloc, UserInsertState>(
              listener: (context, state) {
                if (state is UserInsertNetworkError) {
                  RequestUtil.catchNetworkError(context: context, obj: state.error);
                } else if (state is UserInsertSuccess) {
                  if(AutoRouter.of(context).canPop()) {
                    AutoRouter.of(context).pop<User>(state.user);
                  } 
                } 
              },
              builder: (context, state) {
                Widget body  = const SizedBox();
                if(state is UserInsertLoading) {
                  body = const Expanded(
                    child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                  );                  
                } else if (state is UserInsertInitial) {
                  body = Expanded(
                    child: RawScrollbar(
                      thumbColor: AppStyles.colorGrey2,
                      thumbVisibility: true,
                      interactive: true,
                      controller: _controller,
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 1000,
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
                                          labelText:UserActionFieldNames.date.message,
                                          initialValue: DateTime.now().toStringFormatted(),
                                          onSaved: (value) => _userInsertBody = 
                                          _userInsertBody.copyWith(createDate: DateTime.now()),                                          
                                        ))
                                    ),
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: InputField(
                                          maxLength: 255,
                                          mandatory: true,
                                          labelText: UserActionFieldNames.name.message,
                                          onSaved: (value) => _userInsertBody = _userInsertBody.copyWith(name: value),
                                        ))
                                    ),
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: InputField(
                                          maxLength: 255,
                                          mandatory: true,
                                          labelText: UserActionFieldNames.login.message,
                                          onSaved: (value) => _userInsertBody = _userInsertBody.copyWith(login: value),                                          
                                        ))
                                    ),
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,                  
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: InputField(
                                          isReadOnly: true,
                                          initialValue: typeDescription(),
                                          labelText: UserActionFieldNames.role.message,  
                                          onSaved: (value) => _userInsertBody = _userInsertBody.copyWith(typeId: widget.selectedTypeId),                                      
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
                                          labelText: UserActionFieldNames.password.message,
                                          onSaved: (value) => _userInsertBody = _userInsertBody.copyWith(password: value),      
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
                                        
                                      )
                                    ),                                    
                                    Div(
                                      divison: const Division(
                                        colL: 3,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: StatusSwitcher(
                                          value: _userInsertBody.blocked ?? false,
                                          text: UserActionFieldNames.enable.message, 
                                          onChanged: (value) => _userInsertBody = _userInsertBody.copyWith(blocked: value)    
                                      ))
                                    ),                           
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));
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
          ]         
        ),
      );

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<UserInsertBloc>().add(UserInsertRun(_userInsertBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const UsersRoute(), predicate: (route) => false);
    }
  }   

  String typeDescription() {
    var description = '';
    switch (widget.selectedTypeId) {
      case 1:
        description = UserTypeRoleById.admin.name;
        break;
      case 2:
        description = UserTypeRoleById.user.name;
        break;
      case 4:
        description = UserTypeRoleById.userViewer.name;
        break;                
    }
    return description;
  }

   String typeDescriptionTitle() {
    var description = '';
    switch (widget.selectedTypeId) {
      case 1:
        description = 'Добавление администратора';
        break;
      case 2:
        description = 'Добавление пользователя';
        break;
      case 4:
        description = 'Добавление участника просмотра пользователей';
        break;                
    }
    return description;
  } 
}
