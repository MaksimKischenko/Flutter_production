import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';

import 'widgets/widget.dart';


@RoutePage<User>()
class UserEditScreen extends StatelessWidget {

  static const pageRoute = '/user_edit';
  static const pageName = 'Редактирование пользователя';

  final int? userId;
  final User? user;

  const UserEditScreen({
    Key? key,
    @PathParam('id') this.userId,
    this.user,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocProvider<UserUpdateBloc>(
      create: (context) => UserUpdateBloc(
        id:  userId ?? 0,
        user: user ?? User.empty()
      )..add(UserUpdateInit()),
      child: const UserEditScreenBody() 
    )
  );
}