import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'user_update_event.dart';
part 'user_update_state.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'user_update_bloc');

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  DataManager dataManager;

  final int id;
  User? user;
  bool _patchIsAvaliable = true;

  UserUpdateBloc({
    required this.id,
    required this.user,
  })  : dataManager = InjectionComponent.getDependency<DataManager>(),
        super(UserUpdateInitLoading());

  @override
  Stream<UserUpdateState> mapEventToState(
    UserUpdateEvent event,
  ) async* {
    if (event is UserUpdateInit) {
      yield* _mapUserUpdateInitToState(event);
    } else if (event is UserUpdateRun) {
      yield* _mapUserUpdateRunToState(event);
    }
  }

  Stream<UserUpdateState> _mapUserUpdateInitToState(
      UserUpdateInit event) async* {
    _patchIsAvaliable = dataManager.userRights
        .isAvailable(EntityMethod.patchM, EntityName.user);

    yield UserUpdateInitLoading();

    try {
      if (user == null) {
        final usersResponse = await dataManager.getUsersRequest(id: id);

        if (usersResponse.isEmpty) throw Exception('User not found');
        user = usersResponse.first;
      }

      final listOFSelectedItemIds = <int>[];
      final comparisonList = <int>[];

      final rolesResponse = await dataManager.getRoleRequest();
      final userRolesResponse =
          await dataManager.getUserRoleRequest(userName: user?.login ?? '');
      for (final role in rolesResponse) {
        for (final userRole in userRolesResponse) {
          if(role.id == userRole.id) listOFSelectedItemIds.add(role.id);
          if(role.id == userRole.id) comparisonList.add(role.id);
          continue;
        }
      }

      yield UserUpdateInitial(
        user: user!,
        userRoles: userRolesResponse,
        roles: rolesResponse,
        selectedRoles: listOFSelectedItemIds,
        comparisonList: comparisonList,
      );
 
    } on Exception catch  (error, _) {
      yield UserUpdateInitError(error: error);
    }
  }

  Stream<UserUpdateState> _mapUserUpdateRunToState(UserUpdateRun event) async* {
    yield UserUpdateLoading();

    try {
      final response = _patchIsAvaliable
          ? await dataManager.userUpdateRequest(id: id, request: event.user)
          : null;

      
      if(event.listOFSelectedItemIds != null) {
          await dataManager.setUserRoleRequest(
            userIds: event.listOFSelectedItemIds ?? [],
            userName: user?.login ?? ''
          );
      }
      
      yield _patchIsAvaliable
          ? UserUpdateSuccess(user: response)
          : const UserUpdateError(error: AppConfig.patchIsNotAvaliableUser);

    } on Exception catch  (error, _) {
      yield UserUpdateError(error: error);
    }
  }
}
