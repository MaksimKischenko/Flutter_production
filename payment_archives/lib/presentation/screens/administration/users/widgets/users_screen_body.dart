import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/administration/users/listeners/listeners.dart';
import 'package:payment_tracking_module/presentation/screens/administration/users/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';


class UsersScreenBody extends StatelessWidget {

  const UsersScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? _isSelected;
    User? _selectedUser;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [        
          if (getIt<DataManager>().tokendata?.userType == UserTypeRoleById.userViewer) const SizedBox.shrink() 
          else BlocConsumer<RowSelectedBloc<User>, RowSelectedState<User>>(
            listener: (context, state) {
              _isSelected = state.selectedData.isSelected;
              _selectedUser = state.selectedData.selectedObject;               
            },
            builder: (context, state) => UsersButtonsMenu(
              isSelected: _isSelected ?? false,
              user: _selectedUser,
            ),
          ),
          BlocConsumer<UsersBloc, UsersState>(
            listener: (context, state) => UsersListener.
             fromActions(
               context, 
               state, 
               () => null
             ),
            builder: (context, state) {
              Widget body = const SizedBox();
              if (state is UsersLoading) {
                body = const Expanded(
                  child: Center(
                    child: LoadingIndicator(indicatorsSize: 72)
                  ),
                );
              } else if (state is UsersLoaded) {
                body = Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: UsersTable(
                          users: state.users,
                        ),
                      ),                    
                    ],
                  ),
                );
              }
              return body;
            },
          ),           
        ],
      ),
    );
  }  
}
