import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  DataManager dataManager;

  UsersBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(UsersLoading());

  UsersBlockStatus? _blockStatus;
  UserType? _type;
  int? _supplierId;
  String? _fio;
  UsersSort _sort = AppConfig.usersDefaultSort;
  bool _sortAscending = AppConfig.usersDefaultSortAscending;
  bool _isLoadMoreAvaiable = true;
  List<UserType> _types = [];
  List<Supplier> _suppliers = [];
  List<User> _users = [];
  bool _getIsAvaliableUser = true;
  bool _getIsAvaliableUserType = true;
  bool _postIsAvaliableUser = true;
  bool _patchIsAvaliableUser = true;
  bool _deleteIsAvaliableUser = true;
  bool _getIsAvaliableSupplier = true;
  bool _resetPasswordIsAvaliableUser = true;

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is UsersInit) {
      yield* _mapUsersInitToState(event);
    } else if (event is UsersLoad) {
      yield* _mapUsersLoadToState(event);
    } else if (event is UsersLoadMore) {
      yield* _mapUsersLoadMoreToState(event);
    } else if (event is UsersDeleteUser) {
      yield* _mapUsersDeleteUserToState(event);
    } else if (event is UsersDeleteGroupUser) {
      yield* _mapUsersDeleteGroupUserToState(event);
    } else if (event is UsersChangeUserStatus) {
      yield* _mapUsersChangeUserStatusToState(event);
    } else if (event is UsersChangeGroupUserStatus) {
      yield* _mapUsersChangeGroupUserStatusToState(event);
    } else if (event is UsersUpdateUser) {
      yield* _mapUsersUpdateUserToState(event);
    } else if (event is UsersResetUserPassword) {
      yield* _mapUsersResetUserPasswordToState(event);
    } else if (event is UsersNewUser) {
      yield* _mapUsersNewUserToState(event);
    }
  }

  Stream<UsersState> _mapUsersInitToState(
    UsersInit event
  ) async* {
    _getIsAvaliableUser = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.user); 
    _getIsAvaliableUserType =  dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.userType);
    _getIsAvaliableSupplier = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.supplier);
    _postIsAvaliableUser = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.user);
    _patchIsAvaliableUser = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.user);
    _deleteIsAvaliableUser = dataManager.userRights.isAvailable(EntityMethod.deleteM, EntityName.user);
    _resetPasswordIsAvaliableUser = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.userResetPassword);

    yield UsersInitLoading();

    try {
      final suppliersResponse = _getIsAvaliableSupplier? await dataManager.getSuppliersRequest(
        select: 'supplier_id,supplier_name,supplier_unp'
      ) : null;
      _suppliers = suppliersResponse ?? [];

      final typesResponse = _getIsAvaliableUserType? await dataManager.getUserTypeRequest(): null;

      _types = typesResponse ?? [];

      yield UsersLoaded(
        users: _users,
        sort: _sort,
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable,
        types: _types,
        selectedType: _type,
        suppliers: _suppliers,
        supplierId: _supplierId,
        getIsAvaliableUser: _getIsAvaliableUser,
        getIsAvaliableUserType: _getIsAvaliableUserType,
        getIsAvaliableSupplier: _getIsAvaliableSupplier,
        patchIsAvaliableUser: _patchIsAvaliableUser,
        deleteIsAvaliableUser: _deleteIsAvaliableUser,
        postIsAvaliableUser: _postIsAvaliableUser, 
        resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser
      );
    
    } on Exception catch  (error, _){
      yield UsersInitError(
        error: error
      );
    }
  }

  Stream<UsersState> _mapUsersLoadToState(
    UsersLoad event
  ) async* {
    yield UsersLoading();

    try {

      final response = _getIsAvaliableUser? await dataManager.getUsersRequest(
        count: event.loadCount,
        status: event.blockStatus,
        type: event.type,
        supplierId: event.supplierId,
        fio: event.fio,
        sort: event.sort ?? AppConfig.usersDefaultSort,
        sortAscending: event.sortAscending ?? AppConfig.usersDefaultSortAscending,
      ): <User>[];

      _blockStatus = event.blockStatus;
      _type = event.type;
      _supplierId = event.supplierId;
      _fio = event.fio;
      if (event.sort != null) _sort = event.sort!;
      if (event.sortAscending != null) _sortAscending = event.sortAscending!;

      _users = response;
      _isLoadMoreAvaiable = !(response.length < AppConfig.suppliersGetLoadCount);
    
    } on Exception catch  (error, _){
      yield UsersError(
        error: error
      );
    }

    yield _getIsAvaliableUser? UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser
    ) : const UserGetNotAllow(
      message: AppConfig.getIsNotAvaliableUser
    );
  }

  Stream<UsersState> _mapUsersLoadMoreToState(
    UsersLoadMore event
  ) async* {
    yield UsersLoading();

    try {
      final response = await dataManager.getUsersRequest(
        count: AppConfig.usersGetLoadCount,
        offset: event.offset,
        status: _blockStatus,
        type: _type,
        supplierId: _supplierId,
        fio: _fio,
        sort: _sort,
        sortAscending: _sortAscending
      );

      _users.addAll(response);
      _isLoadMoreAvaiable = !(response.length < AppConfig.suppliersGetLoadCount);
    
    } on Exception catch  (error, _){
      yield UsersError(
        error: error
      );
    }

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }

  Stream<UsersState> _mapUsersDeleteUserToState(
    UsersDeleteUser event
  ) async* {
    yield UsersLoading();

    try {
      await dataManager.userDeleteRequest(id: event.userId);

      _users.removeWhere((e) => e.id == event.userId);

      yield UsersDeleteUserSuccess(
        event.userId
      );
    
    } on Exception catch  (error, _){
      yield UsersError(
        error: error
      );
    }

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }

   Stream<UsersState> _mapUsersDeleteGroupUserToState(
    UsersDeleteGroupUser event
  ) async* {
    yield UsersLoading();

    try {
      await dataManager.usersDeleteRequest(ids: event.userIds);

      yield UsersDeleteGroupUserSuccess();

      _users.removeWhere((e) => event.userIds.contains(e.id));
      
    
    } on Exception catch  (error, _){
      yield UsersError(
        error: error
      );
    }

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }


  Stream<UsersState> _mapUsersChangeUserStatusToState(
    UsersChangeUserStatus event
  ) async* {
    yield UsersLoading();

    try {
      final response = await dataManager.userUpdateRequest(
        id: event.id,
        request: UserUpdateRequest(
          blocked: !event.blocked,
        )
      );

      final index = _users.indexWhere((e) => e.id == event.id);
      if (index > -1) {
        _users[index] = response;
      }
    
    } on Exception catch  (error, _){
      yield UsersError(
        error: error
      );
    }

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }

  Stream<UsersState> _mapUsersChangeGroupUserStatusToState(
    UsersChangeGroupUserStatus event
  ) async* {
    yield UsersLoading();

    try {

      final response = await dataManager.usersUpdateRequest(
        ids: event.userIds,
        request: UserUpdateRequest(
          blocked: event.blocked,
        )
      );

      for (final updatedUser in response) {
        _users[_users.indexWhere((element) => element.id == updatedUser.id)] = updatedUser;
      }


      yield UsersChangeUserStatusSuccess();

      // final updatedResponse =  await dataManager.getUsersRequest(
      //   count: AppConfig.usersGetLoadCount,
      //   status: _blockStatus,
      //   type: _type,
      //   supplierId: _supplierId,
      //   fio: _fio,
      //   sort: _sort,
      //   sortAscending: _sortAscending
      // );

      // _updatedUsers = updatedResponse;

    
    } on Exception catch  (error, _){
      yield UsersError(
        error: error
      );
    }

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }


  Stream<UsersState> _mapUsersUpdateUserToState(
    UsersUpdateUser event
  ) async* {
    yield UsersLoading();

    final index = _users.indexWhere((e) => e.id == event.user.id);
    if (index > -1) {
      _users[index] = event.user;
    }

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }

  Stream<UsersState> _mapUsersResetUserPasswordToState(
    UsersResetUserPassword event
  ) async* {
    yield UsersLoading();

    try {
      await dataManager.userResetPasswordRequest(
        userLogin: event.userLogin,
      );

      yield UsersResetUserPasswordSuccess();
    
    } on Exception catch  (error, _){
      yield UsersError(
        error: error
      );
    }

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }

  Stream<UsersState> _mapUsersNewUserToState(
    UsersNewUser event
  ) async* {
    yield UsersLoading();

    _users.insert(0, event.user);

    yield UsersLoaded(
      users: _users,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      types: _types,
      selectedType: _type,
      suppliers: _suppliers,
      supplierId: _supplierId,
      getIsAvaliableUser: _getIsAvaliableUser,
      getIsAvaliableUserType: _getIsAvaliableUserType,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      patchIsAvaliableUser: _patchIsAvaliableUser,
      deleteIsAvaliableUser: _deleteIsAvaliableUser,
      postIsAvaliableUser: _postIsAvaliableUser,
      resetPasswordIsAvaliableUser: _resetPasswordIsAvaliableUser      
    );
  }
}
