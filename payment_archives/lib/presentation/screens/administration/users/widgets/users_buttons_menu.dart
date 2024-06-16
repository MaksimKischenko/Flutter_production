import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class UsersButtonsMenu extends StatefulWidget {
  final bool isSelected;
  final User? user;

  const UsersButtonsMenu({
    required this.isSelected,
    required this.user,
    super.key
  });

  @override
  State<UsersButtonsMenu> createState() => _UsersButtonsMenuState();
}

class _UsersButtonsMenuState extends State<UsersButtonsMenu> {
  int? typeId;
  

  @override
  Widget build(BuildContext context) => BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          if(state is UsersLoaded) {
            typeId = state.typeId; 
          }
        },
        child: Row(
          children: [
            ChangeGolorButton(
                name: ButtonNames.add.message,
                onTap: () async => _toUserAddScreen(context)),
            const SizedBox(width: 8),
            SimpleButton(
                isActive: widget.isSelected,
                name: ButtonNames.edit.message,
                onTap: () async => _toUserEditScreen(context)),  
            SimpleButton(
                isActive: widget.isSelected,
                name: ButtonNames.delete.message,
                onTap: () async => _userDelete(context)),
          ],
        ),
      );

  Future<void> _toUserAddScreen(BuildContext context) async {
    final _user = await AutoRouter.of(context)
        .push<User>(UserAddRoute(selectedTypeId: typeId));

    if (_user != null) {
      context.read<UsersBloc>().add(NewUserUpdateTable(newUser: _user));
    }  
  }

  Future<void> _toUserEditScreen(BuildContext context) async {
    final _user = await AutoRouter.of(context)
        .push<User>(UserEditRoute(user: widget.user, userId: widget.user?.id ?? 0));

    if (_user != null) {
      context.read<UsersBloc>().add(EditedUserUpdateTable(_user));
    }
  }

  Future<void> _userDelete(BuildContext context) async {
    DialogPlatform.showDecisionMessage(
      context: context,
      message: '',
      action: () =>
          context.read<UsersBloc>().add(UsersDeleteUser(widget.user?.id ?? 0)),
      dialogTitle: 'Уверены, что хотите удалить пользователя?',
      buttonTitle: 'Удалить',
      cancelButtonTitle: 'Нет'
    );
  }
}


