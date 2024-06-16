import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

part 'user_insert_event.dart';
part 'user_insert_state.dart';

class UserInsertBloc extends Bloc<UserInsertEvent, UserInsertState> {
  DataManager dataManager;

  UserInsertBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(UserInsertInitLoading());

  bool _postIsAvaliable = true;


  @override
  Stream<UserInsertState> mapEventToState(
    UserInsertEvent event,
  ) async* {
    if (event is UserInsertInit) {
      yield* _mapUserInsertInitToState(event);
    } else if (event is UserInsertRun) {
      yield* _mapUserInsertRunToState(event);
    }
  }

  Stream<UserInsertState> _mapUserInsertInitToState(
    UserInsertInit event
  ) async* {

    _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.user);

    yield UserInsertInitLoading();

    try {
      final typesResponse = await dataManager.getUserTypeRequest();

      final suppliersResponse =  await dataManager.getSuppliersRequest(
        select: 'supplier_id,supplier_name,supplier_unp'
      );
      
      yield UserInsertInitial(
        types: typesResponse,
        suppliers: suppliersResponse,
      );
    
    } on Exception catch  (error, _){
      yield UserInsertInitError(
        error: error
      );
    }
  }

  Stream<UserInsertState> _mapUserInsertRunToState(
    UserInsertRun event
  ) async* {
    yield UserInsertLoading();

    try {
      final response = _postIsAvaliable? await dataManager.userInsertRequest(event.user.copyWith(
        dateAdd: DateTime.now().toStringFormattedRunOperation()
      )) : null;

      yield _postIsAvaliable? UserInsertSuccess(
        user: response
      ) : const UserInsertError(error: AppConfig.postIsNotAvaliableUser);
    
    } on Exception catch  (error, _){
      yield UserInsertError(
        error: error
      );
    }
  }
}
