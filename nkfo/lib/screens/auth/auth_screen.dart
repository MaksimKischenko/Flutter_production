import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';


class AuthScreen extends StatefulWidget {
  static const pageName = 'Авторизация';

  final String? next;

  const AuthScreen({
    required this.next
  });

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _formKey = GlobalKey<FormState>();
  final _loginFocusNode = FocusNode();
  final _passwordFocusNode  = FocusNode();

  String _login = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthBloc>().state is AuthAuthorized) {
        Navigation.toOrganizations();
      }
    });
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          RequestUtil.catchNetworkError(
            context: context,
            obj: state.error
          );
        } else if (state is AuthAuthorized) {
          if (state.next?.isEmpty ?? true) {
            Navigation.toOrganizations();
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              state.next!,
              (route) => false
            );
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/background.jpg'),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  colors: [
                    Color.fromRGBO(147, 217, 208, .7),
                    Color.fromRGBO(90, 113, 144, .7)
                  ],
                  stops: [
                    0.0,
                    1.0
                  ]
                )
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) 
                => ResponsiveLayoutElement(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    sizingInformation: sizingInformation,
                    children: [
                       Text(
                        'Панель\nадминистрирования',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 32,
                          letterSpacing: 0.04,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      //const SizedBox(width: 200),
                      Container(
                        width: 350,
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: double.maxFinite),
                                  LoadingIndicator()
                                ],
                              );
                            } else {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/logo.jpg', height: 40),
                                    const SizedBox(height: 48),
                                    AttrTextField(
                                      initialValue: kDebugMode? 'root' : '',
                                      labelText: 'Логин',
                                      focusNode: _loginFocusNode,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Поле обязательное для заполнения';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _login = value;
                                      },
                                      onFieldSubmitted: (_) {
                                        _loginFocusNode.unfocus();
                                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    PasswordTextField(
                                      initialValue: kDebugMode? '123456': '',
                                      labelText: 'Пароль',
                                      focusNode: _passwordFocusNode,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Поле обязательное для заполнения';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _password = value;
                                      },
                                      onFieldSubmitted: (_) {
                                        _onAuthTap();
                                      },
                                    ),
                                    const SizedBox(height: 32),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: EnterButton(onAuthTap: _onAuthTap)
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                        ),
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );

  void _onAuthTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<AuthBloc>().add(AuthRun(
        login: _login,
        password: _password,
        next: widget.next
      ));
    }
  }
}
