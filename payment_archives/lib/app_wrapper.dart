import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/app_config.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/data/data_manager.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/routing/routes.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'presentation/bloc/blocs.dart';


class AppWrapper extends StatelessWidget {
  final Widget child;
  const AppWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     setPageTitle(context);
     return MultiBlocProvider(
      providers: [       
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ChangePasswordBloc>(
          create: (context) => ChangePasswordBloc(),
        ),
        BlocProvider<RowSelectedBloc>(
          create: (context) => RowSelectedBloc()
        ),                  
        BlocProvider<ArchiveDbBloc>(
          create: (context) => ArchiveDbBloc()
        ),   
        BlocProvider<ArchiveLocationBloc>(
          create: (context) => ArchiveLocationBloc()
        ),   
        BlocProvider<ArchiveLocationInsertBloc>(
          create: (context) => ArchiveLocationInsertBloc()
        ),               
        BlocProvider<ArchiveStatusBloc>(
          create: (context) => ArchiveStatusBloc()
        ),  
        BlocProvider<AuditLogBloc>(
          create: (context) => AuditLogBloc()
        ),         
        BlocProvider<DataSourceBloc>(
          create: (context) => DataSourceBloc()
        ),  
        BlocProvider<DataSourceInsertBloc>(
          create: (context) => DataSourceInsertBloc()
        ),                  
        BlocProvider<RuleAllocationBloc>(
          create: (context) => RuleAllocationBloc()
        ),   
        BlocProvider<RuleAllocationInsertBloc>(
          create: (context) => RuleAllocationInsertBloc()
        ),                                          
        BlocProvider<UsersBloc>(
          create: (context) => UsersBloc()
        ),   
        BlocProvider<UserInsertBloc>(
          create: (context) => UserInsertBloc()
        ),                              
        BlocProvider<WebSocketBloc>(
          create: (context) => WebSocketBloc(),
        ),                     
        BlocProvider<SearchPaymentBloc>(
          create: (context) => SearchPaymentBloc(),
        ),   
        BlocProvider<FormReportsBloc>(
          create: (context) => FormReportsBloc(),
        ),  
                                                 
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthSuccess) {
            timer = Timer.periodic(const Duration(minutes: 5), (Timer t) 
            => _onRefreshToken(
                context,
                getIt<DataManager>(),
              ));  
          } else if (state is AuthLogOutSuccess) {
            timer.cancel();
            getIt<Routes>().pushAndPopUntil(const AuthRoute(), predicate: (route) => false);
          } 
        },
        child: child,
      ),
    ); 
  } 

void  _onRefreshToken(BuildContext context, DataManager dataManager) {
  log('${DateTime.fromMillisecondsSinceEpoch((dataManager.tokendata?.exp ?? 0) * 1000).subtract(const Duration(seconds: 60))}');
  if(dataManager.tokendata != null) {
    context.read<AuthBloc>().add(AuthRefreshToken());
  }
} 

  void setPageTitle(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: AppConfig.appName,
      primaryColor:Theme.of(context).primaryColor.value,
    ));
  }
}

