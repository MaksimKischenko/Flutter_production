import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/local/local_storage.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/screens/auth/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';



class AuthModule extends StatefulWidget {
  const AuthModule({super.key});

  @override
  State<AuthModule> createState() => _AuthModuleState();
}

class _AuthModuleState extends State<AuthModule> {

  late TextEditingController _passwordController;
  late TextEditingController _loginController;
  late GlobalKey<FormState> _authFormKey;
  late FocusNode _loginFocus;
  late FocusNode _passwordFocus;
  late AuthScreenData _data;

  bool saveCredentials = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _loginController = TextEditingController();
    _authFormKey = GlobalKey<FormState>();
    _loginFocus  = FocusNode();
    _passwordFocus = FocusNode();
    _data = AuthScreenData();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCredential());    
  }


  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    _loginFocus.dispose();
    _passwordFocus.dispose();
  }


  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          RequestUtil.catchNetworkError(
            context: context,
            obj: state.error
          );  
        } 
        else if (state is AuthAuthorized) {
          if((state.accessToken ?? '').isNotEmpty) {
            if(state.tokenData?.userType == UserTypeRoleById.admin || state.tokenData?.userType == UserTypeRoleById.userViewer) {
              AutoRouter.of(context).pushAndPopUntil(const UsersRoute(), predicate: (route) => false);
            } else if (state.tokenData?.userType == UserTypeRoleById.user) {
              AutoRouter.of(context).pushAndPopUntil(const PaymentsRoute(), predicate: (route) => false);
            } 
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => ResponsiveLayoutElement(
            sizingInformation: sizingInformation,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  'Архив\nплатежей',
                  textAlign: TextAlign.center,
                  style: AppStyles.authTitleFieldStyle,
                ),
              ),  
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 480,
                  maxWidth: 420
                ),
                child: Form(
                  key: _authFormKey,
                  child: Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Responsive(
                        runSpacing: 16,
                        children: [
                          const Div(
                            divison: Division(
                              colL: 12,
                              colM: 12,  
                            ),
                            child: Text('Войдите в ваш аккаунт', style: AppStyles.authTitleFieldLoginMenu)
                          ),
                          const SizedBox(height: 24),
                          Div(
                            divison: const Division(
                              colL: 12,
                              colM: 12,  
                            ),
                            child: InputField(
                              mandatory: true,
                              controller: _loginController,
                              focusNode: _loginFocus,
                              labelText: 'Логин',
                              onFieldSubmitted: (_) {
                                _loginFocus.unfocus();
                                FocusScope.of(context).requestFocus(_passwordFocus);
                              },
                              onSaved: (login) {
                                _data.login = login;
                              },                              
                            ),
                          ),
                          Div(
                            divison: const Division(
                              colL: 12,
                              colM: 12,  
                            ),
                            child: PasswordInputField(
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              labelText: 'Пароль',
                              onFieldSubmitted: (_) {
                                _onAuthPressed();
                              },
                              onSaved: (password) {
                                _data.password = password;
                              }, 
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
                          Div(
                            divison: const Division(
                              colL: 12,
                              colM: 12,  
                            ),
                            child: EnterButton(
                              onAuthTap: _onAuthPressed,
                            )
                          ),                               
                          Div(
                            divison: const Division(
                              colL: 12,
                              colM: 12,  
                            ), 
                            child: 
                            Row(
                              children: [
                                Expanded(
                                  child: StatusSwitcher(
                                    activeColor: AppStyles.colorGold,
                                    text: 'Запомнить пароль', 
                                    value: saveCredentials,
                                    onChanged: (value) {
                                      setState(() {
                                        saveCredentials = value;
                                      });
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),                                                        
                        ],
                      ),
                    ),
                  ),
                ),
                  ),                
            ],
          )
        ),
      )
    );

    void _onAuthPressed() {
      if (_authFormKey.currentState?.validate() ?? false) {
        _authFormKey.currentState?.save();
        context.read<AuthBloc>().add(AuthRun(
          data: _data,
          saveCredentials: saveCredentials
        ));
      }
    }

    Future<void> _loadCredential() async {
      final info = await LocalStorage.getCredentials();
      _loginController.text =   info.item1 ?? ''; 
      _passwordController.text =   info.item2 ?? ''; 
      saveCredentials = info.item1 != null;
      setState(() {});
    }
  }
        
        
      