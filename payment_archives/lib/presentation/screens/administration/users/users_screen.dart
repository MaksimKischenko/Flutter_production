import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/administration/users/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

import 'widgets/users_screen_body.dart';

@RoutePage()
class UsersScreen extends StatefulWidget {
  static const String pageRoute = '/users';

  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  var _selectedItem = UserTypeRoleById.user;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          DrawerMenu(
            selectedIndex: 0,
            selecdedExpandedIndex: 1,
          ),
          Expanded(
            child: Column(
              children: [    
                const SizedBox(height: 20),
                Center(
                  child: Text('Пользователи', style: AppStyles.headerStyle)
                ),    
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      child: UserTypePicker(
                        selected: _selectedItem,
                        items: UserTypeRoleById.values,
                        onTap: (item) {
                          setState(() {
                            _selectedItem = item;   
                          });
                        },
                      ),
                    ),
                  ),
                ),                                             
                BlocProvider(
                  create: (context) => RowSelectedBloc<User>(),
                  child: const Expanded(
                    child: UsersScreenBody()
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    )
  );
}
